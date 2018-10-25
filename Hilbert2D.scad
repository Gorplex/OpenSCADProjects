
// Global resolution
$fs = 0.05;  // Don't generate smaller facets than 0.1 mm
$fa = 5;    // Don't generate larger angles than 5 degrees

MXID = [[1,0,0],[0,1,0],[0,0,1]];
MX90 = [[0,1,0],[-1,0,0],[0,0,1]];
MX270 = [[0,-1,0],[1,0,0],[0,0,1]];
MXMRYeqX = [[0,1,0],[1,0,0],[0,0,1]];
MXMRYeqnX = [[0,-1,0],[-1,0,0],[0,0,1]];

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

function TransformList(pointList, matrix = MXID) = [for (p=pointList) p*matrix];
function TranslateList(pointList, offset=[0,0,0]) = [for (p=pointList) p+offset];

scaleFact = .5;
BASE = [[-area/2,-area/2,0],[-area/2,area/2,0],[area/2,area/2,0],[area/2,-area/2,0]];
function Hilbert(step=0) = step == 0 ? BASE : concat(
    TranslateList(TransformList(Hilbert(step-1),scaleFact*MXMRYeqX), [-area/2,-area/2,0]), 
    TranslateList(TransformList(Hilbert(step-1), scaleFact*MXID), [-area/2,area/2,0]),
    TranslateList(TransformList(Hilbert(step-1), scaleFact*MXID), [area/2,area/2,0]),
    TranslateList(TransformList(Hilbert(step-1), scaleFact*MXMRYeqnX), [area/2,-area/2,0]));


Bars(Hilbert(5));



