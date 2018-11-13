
// Global resolution
$fs = 0.05;  // Don't generate smaller facets than 0.1 mm
$fa = 5;    // Don't generate larger angles than 5 degrees

mainHeight = 2.9;
shoulder = .1;
error=1;
shaftDia = .5125;
cylDia =.75;
keySize = .1;

module Blades(){
    steps = 50;
    tMin = 10;
    tMax = 180;
    tStep = (tMax-tMin)/steps;
    angShft0 = 20;   
    angShft1 = 5;
    angShftStep = (angShft1-angShft0)/steps;
    rMin = cylDia/2;
    rMax = 2.5;
    rStep = (rMax-rMin)/steps;
    
    p1 = [for (i=[0:1:steps]) [(rMin+rStep*i)*cos(i*tStep+tMin),(rMin+rStep*i)*sin(i*tStep+tMin)]];
    p2 = [for (i=[steps:-1:0]) [(rMin+rStep*i)*cos(i*tStep+tMin+angShft0+angShftStep*i),(rMin+rStep*i)*sin(i*tStep+tMin+angShft0+angShftStep*i)]];

    points = concat(p1,p2);
    //echo(points);
    for( i=[0:90:270]){
        rotate([0,0,i]){
            polygon(points); 
        }
    }
}



module Wheel(){
    
    translate([0,0,mainHeight/2])
    union(){
       linear_extrude(height = mainHeight/2-shoulder, scale=.1,twist=45)
       Blades();
       mirror([0,0,1])
       linear_extrude(height = mainHeight/2-shoulder, scale=.1,twist=45)
       Blades(); 
    }
}

module Shaft(){
    
    color("Red")
    union(){
        cylinder(mainHeight+error,shaftDia/2,shaftDia/2);
        translate([shaftDia/2,0,mainHeight/2])
        cube([keySize,keySize,mainHeight],true);
    }
}

module Cyl(){
    color("Green")
    cylinder(mainHeight,cylDia/2,cylDia/2);
}
//temp
//translate([0,0,mainHeight/2])
//cube([keySize,keySize,mainHeight],true);


color("Blue")
difference(){
    union(){
        Wheel();
        Cyl();
    }
    Shaft();
}