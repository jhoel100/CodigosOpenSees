# definir el tipo de modelo a calcular
	model basic -ndm 2 -ndf 3;
# definir los nudos del problema
# 	introducir nudos en el siguiente formato
#   node | numeroDeNudo | coordX coordY;
	node 1 0.0 2.5;
	node 2 3.2 7.0;
	node 3 7.60 0.0;
	node 4 7.60 4.0;
	node 5 6.60 6.0;
	node 6 10.1 4.0;
	node 7 11.3 0.0;
	node 8 11.3 4.0;

# definir la transformación de coordenadas
	geomTransf Linear 1;

# definir nuestras barras
#	element | elasticBeamColumn | numElemento | deNudo | aNudo | Area | modElas | Inercia | transfCoord
	set A [expr 0.25*0.40];
	set E 25000000;
	set I [expr 0.25*pow(0.4,3.0)/12.0];
	element elasticBeamColumn 1 1 2 $A $E $I 1;
	element elasticBeamColumn 2 2 5 $A $E $I 1;
	element elasticBeamColumn 3 3 4 $A $E $I 1;
	element elasticBeamColumn 4 4 5 $A $E $I 1;
	element elasticBeamColumn 5 4 6 $A $E $I 1;
	element elasticBeamColumn 6 6 8 $A $E $I 1;
	element elasticBeamColumn 7 7 8 $A $E $I 1;

#ingreso de restricciones
# fix | numNudo | desplX | desplY | rotacion
	fix 1 1 1 0;
	fix 3 1 1 1;
	fix 7 0 1 0;

# establecer una serie de tiempo
	timeSeries Linear 101; 

# patron de cargas
	pattern Plain 201 101 {
		eleLoad -ele 1 -type beamUniform -20;
		eleLoad -ele 2 -type beamUniform -30;
		eleLoad -ele 3 -type beamUniform -15;
		load 6 0 -65 0;
	}

# grabando resultados en archivos
	recorder Node -file nodeReact.out -time -node -dof 1 2 3 reaction;

# Resolución del modelo
	constraints Plain;
	numberer Plain;
	system FullGeneral;
	test NormDispIncr 1e-12 10;
	algorithm Newton;
	integrator LoadControl 1.0;
	analysis Static;
	analyze 1;

	print -file resultados.out;
