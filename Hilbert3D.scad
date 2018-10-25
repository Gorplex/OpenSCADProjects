
// Global resolution
$fs = 0.05;  // Don't generate smaller facets than 0.1 mm
$fa = 5;    // Don't generate larger angles than 5 degrees

MXID = [[1,0,0],[0,1,0],[0,0,1]];
//X
MXX90 = [[1,0,0],[0,0,1],[0,-1,0]];
MXX180 = [[1,0,0],[0,-1,0],[0,0,-1]];
MXX270 = [[1,0,0],[0,0,-1],[0,1,0]];
//Y
MXY90 = [[0,0,-1],[0,1,0],[1,0,0]];
MXY180 = [[-1,0,0],[0,1,0],[0,0,-1]];
MXY270 = [[0,0,1],[0,1,0],[-1,0,0]];
//Z
MXZ90 = [[0,1,0],[-1,0,0],[0,0,1]];
MXZ180 = [[-1,0,0],[0,-1,0],[0,0,1]];
MXZ270 = [[0,-1,0],[1,0,0],[0,0,1]];

//other
MXMRYeqX = [[0,1,0],[1,0,0],[0,0,1]];
MXMRYeqnX = [[0,-1,0],[-1,0,0],[0,0,1]];

//Hilbert 3D
HB1 = MXX270*MXY270;
HB2 = MXX90*MXZ90;
HB3 = HB2;
HB4 = MXX180;
HB5 = HB4;
HB6 = MXX90*MXZ270;
HB7 = HB6;
HB8 = MXX270*MXY90;

area = 10; //readius or the square area

function vlen(point) = sqrt(pow(point[0],2)+pow(point[1],2)+pow(point[2],2));

function dist(point1, point2) = vlen(point2-point1);
function azimuth(point) = atan2(point[1],point[0]);
function altitude(point) = -1*atan2(point[2],sqrt(pow(point[0],2)+pow(point[1],2)));

module Bar(point1, point2, width=.2){
    vec = point2-point1;
    length = vlen(vec);
    aziAng = azimuth(vec);
    altAng = altitude(vec);
    
    translate(point1)
    rotate([0,altAng,aziAng])
    translate([length/2,0,0])
    cube([length+width,width,width],center=true);
}
module Bars(pointList){
    for(i=[0:1:len(pointList)-2]){
        Bar(pointList[i],pointList[i+1]);
    }
}
module ColorBars(pointList){
    colors = ["red", ,"orange", "yellow", "green", "cyan", "blue", "violet", "purple"];
    numCol = len(colors);
    length = len(pointList);
    for(i=[0:1:len(pointList)-2]){
        color(colors[i/(length/numCol)])
        Bar(pointList[i],pointList[i+1]);
    }
}


function TransformList(pointList, matrix = MXID) = [for (p=pointList) p*matrix];
function TranslateList(pointList, offset=[0,0,0]) = [for (p=pointList) p+offset];
//Hilbert Consts
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

ColorBars(Hilbert3D(2));


