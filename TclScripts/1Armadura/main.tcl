wipe

#creacion de modelo 2D 
model BasicBuilder -ndm 2 -ndf 2

#inclusion de nodos
#nro posicion
node 1   0.0  0.0
node 2 144.0  0.0
node 3 168.0  0.0
node 4  72.0 96.0

#restriccion de nodos 
#nro de nodo 1 indica restringido
#0 indica que no esta restringido
fix 1 1 1 
fix 2 1 1
fix 3 1 1

#Creacion de material
#nombre Tipo ID Modulo Elasticidad
uniaxialMaterial Elastic 1 3000

# Create truss elements - command:
#element Tipo ID nodoi nodoj  Area IDdematerial
element Truss 1 1 4 10.0 1
element Truss 2 2 4  5.0 1
element Truss 3 3 4  5.0 1
    
#Crea un Time Series Linear
timeSeries Linear 1

#Crea un patron linear apartir del time series anterior
#pattern Plain ID ID del Time Series
pattern Plain 1 1 {
    #load nodeID xForce yForce
    load 4 100 -50
}
    
#Crea las matrices almacenando valores en bandas
system BandSPD

#usa reverse Cuthill-McKee algorithm para enumerar los nodos
numberer RCM

# Create the constraint handler, a Plain handler is used as homo constraints
constraints Plain

# Create the integration scheme, the LoadControl scheme using steps of 1.0
integrator LoadControl 1.0

# Create the solution algorithm, a Linear algorithm is created
algorithm Linear

# create the analysis object 
analysis Static 

# ------------------------------
# Start of recorder generation
# ------------------------------

# create a Recorder object for the nodal displacements at node 4
recorder Node -file example.out -time -node 4 -dof 1 2 disp

# Create a recorder for element forces, one in global and the other local system
recorder Element -file eleGlobal.out -time -ele 1 2 3 forces
recorder Element -file eleLocal.out -time -ele 1 2 3  basicForces

# ------------------------------
# Finally perform the analysis
# ------------------------------

# Perform the analysis
analyze 1

# ------------------------------
# Print Stuff to Screen
# ------------------------------

# Print the current state at node 4 and at all elements
puts "node 4 displacement: [nodeDisp 4]"
print node 4
print ele

