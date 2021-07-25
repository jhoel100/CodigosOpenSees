#C:\OpenSees-Solvers\opensees.bat
#D:\Octave\Octave-6.3.0\mingw64\bin\octave.bat

model basic -ndm 2 -ndf 3
# nodal coordinates:
node 1 0 0 
node 2 504 0
node 3 0 432
node 4 504 432 
 
# bondary conditions:
fix 1 1 1 1
fix 2 1 1 1
fix 3 0 0 0
fix 4 0 0 0
 
# nodal masses:
mass 3 5.18 0. 0.
mass 4 5.18 0. 0.
 
# transformation:
geomTransf Linear 1 
 
# element connectivity:
element elasticBeamColumn 1 1 3 3600 4227 1080000 1
element elasticBeamColumn 2 2 4 3600 4227 1080000 1
element elasticBeamColumn 3 3 4 5760 4227 4423680 1
 
# recorders
recorder Node -file Node3.out -time -node 3 -dof 1 2 disp
recorder Element -file Element1.out -time -ele 1 force