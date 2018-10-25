// Global resolution
$fs = 0.01;  // Don't generate smaller facets than 0.1 mm
$fa = 1;    // Don't generate larger angles than 5 degrees

mainHeight = 2.9;
error=.1;
shaftDia = .5125;
keySize = .1;

module Shaft(){
    difference(){
        cylinder(mainHeight+error,shaftDia/2,shaftDia/2);
        translate([shaftDia/2,0,mainHeight/2+error])
        cube([keySize,keySize,mainHeight+2*error],true);
    }
}
