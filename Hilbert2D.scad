include <VectorBar_lib.scad>
include <VectorMatrix_lib.scad>

area = 10; //readius of the square area
scaleFact = .5; //between iterations
BASE = [[-area/2,-area/2,0],[-area/2,area/2,0],[area/2,area/2,0],[area/2,-area/2,0]];
function Hilbert(step=0) = step == 0 ? BASE : concat(
    TranslateList(TransformList(Hilbert(step-1),scaleFact*MXMRYeqX), [-area/2,-area/2,0]), 
    TranslateList(TransformList(Hilbert(step-1), scaleFact*MXID), [-area/2,area/2,0]),
    TranslateList(TransformList(Hilbert(step-1), scaleFact*MXID), [area/2,area/2,0]),
    TranslateList(TransformList(Hilbert(step-1), scaleFact*MXMRYeqnX), [area/2,-area/2,0]));


Bars(Hilbert(5));



