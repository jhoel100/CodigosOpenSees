pattern Plain 1 Linear {
  load 3 0.0 -2000 -168074
  load 4 0.0 -2000 168074
}
 
constraints Transformation
numberer RCM
system BandGeneral
test NormDispIncr 1.0e-6 6
algorithm Newton
integrator LoadControl 0.1
analysis Static
 
analyze 10
loadConst -time 0.0