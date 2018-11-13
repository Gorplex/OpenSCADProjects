$fa = 1;
$fn = 50;

difShift = 1;


PoleZ = 30;
PoleDia = 12;

SlotWidth = 1;
SlotClear = .5;

CarrageZ = 5;
CarrageDia = 8;
CarrageClear = .5;

ScrewDia=2;

module gear(height, diameter, teeth){
    //stick into cylinder 
    difShift = .1;
    union(){
        cylinder(height,d=diameter, true);
        for(i = [0:teeth]){
            rotate([0,0,i*360/teeth])
            translate([diameter/2+1/2,0,height/2])
            cube([1+difShift,1,height],true);
        }
    }
}

module Slot(Z, difShift, Clear){
    translate([CarrageDia/2+CarrageClear+difShift,0,Z/2])
    cube([(PoleDia-CarrageDia)/2+CarrageClear+2*difShift,SlotWidth+SlotClear,Z+2*difShift], true);
}


module Pole() {
    difference(){
        cylinder(PoleZ, d=PoleDia, true);
        translate([0,0,-difShift])
        cylinder(PoleZ+2*difShift, d=CarrageDia+2*CarrageClear, true);
        Slot(PoleZ,difShift, SlotClear);
    }
}
module LeadScrew(difShfit){
    translate([0,0,-difShift])
    cylinder(PoleZ+2*difShift, d=ScrewDia, true);
}


module Carrage(){
    difference(){
        cylinder(CarrageZ, d=CarrageDia+6, true);
        translate([0,0,-difShift])
        Pole();
    }
    /*difference(){
        union(){
            cylinder(CarrageZ, d=CarrageDia, true);
            Slot(CarrageZ,0,0);
        }
        LeadScrew(difShift);
    }*/
}
module UppderCarrage(){
    color("red")
    difference(){
        gear(CarrageZ,CarrageDia+6,10);
        translate([0,0,-difShift])
        cylinder(CarrageZ+2*difShift, d=PoleDia, true);
    }
}

color("green")
gear(2,PoleDia+15,15);

translate([10,0,0])
color("red")
gear(PoleZ,3,8);

color("blue")
LeadScrew(0);
color("green")
Pole();
translate([0,0,PoleZ+2*difShift+CarrageZ-20*$t])

UppderCarrage();
translate([0,0,PoleZ+difShift-20*$t])
color("magenta")
Carrage();
