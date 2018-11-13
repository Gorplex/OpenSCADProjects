include <VectorBar_lib.scad>
include <VectorMatrix_lib.scad>

//Hilbert 3D
HB1 = MXX270*MXY270;
HB2 = MXX90*MXZ90;
HB3 = HB2;
HB4 = MXX180;
HB5 = HB4;
HB6 = MXX90*MXZ270;
HB7 = HB6;
HB8 = MXX270*MXY90;

//Hilbert Consts
area = 10; //readius of the square area
scaleFact = .5;
BASE = (area/2)*[[-1,-1,-1],[-1,-1,1],[-1,1,1],[-1,1,-1],[1,1,-1],[1,1,1],[1,-1,1],[1,-1,-1]];

function Hilbert3D(step=0) = step == 0 ? BASE : concat(
    TranslateList(TransformList(Hilbert3D(step-1),scaleFact*HB1), area/2*[-1,-1,-1]),
    TranslateList(TransformList(Hilbert3D(step-1),scaleFact*HB2), area/2*[-1,-1,1]),
    TranslateList(TransformList(Hilbert3D(step-1),scaleFact*HB3), area/2*[-1,1,1]),
    TranslateList(TransformList(Hilbert3D(step-1),scaleFact*HB4), area/2*[-1,1,-1]),
    TranslateList(TransformList(Hilbert3D(step-1),scaleFact*HB5), area/2*[1,1,-1]),
    TranslateList(TransformList(Hilbert3D(step-1),scaleFact*HB6), area/2*[1,1,1]),
    TranslateList(TransformList(Hilbert3D(step-1),scaleFact*HB7), area/2*[1,-1,1]),
    TranslateList(TransformList(Hilbert3D(step-1),scaleFact*HB8), area/2*[1,-1,-1]));


ColorBars(Hilbert3D(3));


