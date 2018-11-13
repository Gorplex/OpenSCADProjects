$fa = 1;
$fn = 50;
//FPS:30 Steps:400


difShift = 1;


PoleZ = 30;
PoleDia = 12;

SlotWidth = 1;
SlotClear = .5;

CarrageZ = 5;
CarrageDia = 8;
CarrageClear = .5;
OuterCarrageDia=CarrageDia+6;

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

module ShaftMesh(height, diameter, teeth){
    //stick into cylinder 
    difShift = .1;
    toothWidth=1;
    
    difference(){
        cylinder(height,d=diameter, true);
        for(i = [0:teeth]){
            rotate([0,0,i*360/teeth])
            translate([diameter/2-toothWidth/2+difShift,0,height/2])
            cube([toothWidth+difShift,toothWidth,height+2*difShift],true);
        }
        trnaslate([0,0,-difShift])
        cylinder(height+2*difShift,d=diameter-2*toothWidth, true);
    }
}

module Slot(Z, difShift, Clear){
    translate([CarrageDia/2+CarrageClear+difShift,0,Z/2])
    cube([(PoleDia-CarrageDia)/2+CarrageClear+2*difShift,SlotWidth+SlotClear,Z+2*difShift], true);
}


module Pole() {
    color("green")
    difference(){
        union(){
            cylinder(PoleZ, d=PoleDia, true);
            gear(2,PoleDia+15,15);
        }
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
    upperArmLen = 20;
    
    color("magenta")
    union(){
        difference(){
            cylinder(CarrageZ, d=OuterCarrageDia, true);
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
        rotate([0,0,180])
        difference(){
            translate([upperArmLen/2,0,CarrageZ/2])
            cube([upperArmLen, OuterCarrageDia, CarrageZ], true);
            translate([0,0,-difShift])
            cylinder(CarrageZ+2*difShift, d=PoleDia, true);
        }
    }
}
module UppderCarrage(){
    upperArmZ = 5;
    upperArmLen = 20;
    
    color("red")
    difference(){
        union(){
            gear(CarrageZ,OuterCarrageDia,10);
            
            translate([upperArmLen/2,0,CarrageZ+upperArmZ/2])
            cube([upperArmLen, OuterCarrageDia, upperArmZ], true);
        }
        
        translate([0,0,-difShift])
        cylinder(upperArmZ+CarrageZ+2*difShift, d=PoleDia, true);
    }
}

!ShaftMesh(20,15,20);

color("blue")
LeadScrew(0);

rotate([0,0,$t*360])
Pole();

rotate([0,0,$t*360])
translate([0,0,PoleZ+difShift-10*sin($t*360)-10])
Carrage();

translate([0,0,PoleZ+2*difShift+CarrageZ-10*sin($t*360)-10])
rotate([0,0,180*sin($t*360)])
UppderCarrage();

