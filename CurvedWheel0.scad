include <WaterWheelShaft.scad>
// Global resolution
$fs = 0.01;  // Don't generate smaller facets than 0.1 mm
$fa = 1;    // Don't generate larger angles than 5 degrees

mainHeight = 2.9;
shoulder = .1;
error=1;
shaftDia = .5125;
cylDia =.75;
keySize = .1;


module Wheel(){
    tMin = 10;
    tMax = 180;
    tStep = 1;
    angleShift = 20;
    rMin = cylDia/2;
    rMax = 2.5;
    rPERt = (rMax-rMin)/(tMax-tMin);
    
    p1 = [for (t=[tMin:tStep:tMax]) [rPERt*t*cos(t),rPERt*t*sin(t)]];
    p2 = [for (t=[tMax-10:-tStep:tMin]) [rPERt*t*cos(t+angleShift),rPERt*t*sin(t+angleShift)]];

    points = concat(p1,p2);
    //echo(points);
    translate([0,0,shoulder])
    linear_extrude(height = mainHeight-2*shoulder, scale=1)//,twist=0)
    for( i=[0:90:270]){
        rotate([0,0,i]){
            polygon(points); 
        }
    }
    
}


module Cyl(){
    color("Green")
    cylinder(mainHeight,cylDia/2,cylDia/2);
}


difference(){
    union(){
        Wheel();
        Cyl();
    }
    //import("WaterWheelShaft.stl");
    Shaft();
}