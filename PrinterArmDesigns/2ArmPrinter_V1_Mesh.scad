$fa = 1;
$fn = 50;
//FPS:30 Steps:400

difShift = 10;
globalClear = .5;

ScrewRad=2;

PoleZ = 40;
PoleRad = 6;

SlotWidth = 1;
SlotClear = .5;

CarrageZ = 5;
CarrageRad = 4;
CarrageClear = .5;
OuterCarrageRad=8;
UpperArmLen = 40;

//mesh
MeshOffset = 2;
MeshRad = 8;
BarMeshZ = 20;
NumBars = 20;

//lowerCarrage
LowerCarrageRad=8;
LowerArmLen=40;

module BottomMesh(){
    color("blue")
    difference(){
    union(){
        translate([0,0,MeshOffset+1])
        ShaftMesh(BarMeshZ, 2*MeshRad, NumBars);
        translate([0,0,MeshOffset])
        gear(1,2*MeshRad+6, 20);
        }
        ClearenceCyl(globalClear)
        cylinder(PoleZ, r=PoleRad);
    }
}

module ShaftMesh(height, diameter, teeth){
    //stick into cylinder 
    difShift = .1;
    toothWidth=1;
    union(){
        for(i = [0:teeth]){
            rotate([0,0,i*360/teeth])
            translate([diameter/2-toothWidth/2,0,height/2])
            cube([toothWidth,toothWidth,height],true);
        }
    }
}

module LowerCarrage(){
    color("yellow")
    translate([0,0,BarMeshZ+MeshOffset+2])
    difference(){
        union(){
            cylinder(CarrageZ, r=LowerCarrageRad);
            translate([0,0,-BarMeshZ])
            rotate([0,0,360/NumBars/2])
            ShaftMesh(BarMeshZ, 2*MeshRad, NumBars);
            //arm
            rotate([0,0,180])
            translate([0,-OuterCarrageRad,0])
            cube([LowerArmLen, 2*OuterCarrageRad, CarrageZ]);
            
        }
        ClearenceCyl(globalClear)
        cylinder(CarrageZ, r=PoleRad);
    }
}


module UpperCarrage(){
    color("magenta")
    translate([0,0,BarMeshZ+MeshOffset+2+CarrageZ])
    union(){
        //innner Carrage
        difference(){
            cylinder(CarrageZ, r=CarrageRad);
            ClearenceCyl(globalClear)
            cylinder(CarrageZ, r=ScrewRad);
        }
        Slot(CarrageZ);
        //outer Carrage and arm
        difference(){
            union(){
                cylinder(CarrageZ, r=OuterCarrageRad);
                
                //arm
                rotate([0,0,180])
                translate([0,-OuterCarrageRad,0])
                cube([UpperArmLen, 2*OuterCarrageRad, CarrageZ]);
            }   
            ClearenceCyl(globalClear)
            cylinder(CarrageZ, r=PoleRad);
        }
    }
}


module ClearenceCyl(clearence){
    minkowski() { 
        children();
        cylinder(clearence, clearence, clearence, true);
    }
}
module ClearenceCube(clearence){
    minkowski() { 
        children();
        cube(clearence*[1,1,1],true);
    }
}

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

module Slot(slotZ){
    ExtraLen = .5;
    translate([CarrageRad-ExtraLen,-SlotWidth/2,0])
    cube([PoleRad-CarrageRad+2*ExtraLen,SlotWidth,slotZ]);
}

module Pole() {
    color("green")
    union(){
        difference(){
            gear(1,PoleRad*2+15,15);
            ClearenceCyl(globalClear)
            LeadScrew();
        }
        difference(){
            cylinder(PoleZ, r=PoleRad);
            translate([0,0,-difShift])
            ClearenceCyl(globalClear)
            cylinder(PoleZ+2*difShift, r=CarrageRad, true);
            ClearenceCube(globalClear)
            Slot(PoleZ);
        }
    }
}
module LeadScrew(){
    color("red")
    translate([0,0,-5])
    cylinder(PoleZ+10, r=ScrewRad);
}

rotate([0,0,180*sin($t*360)])
translate([0,0,10-10*sin($t*360)])
LowerCarrage();

rotate([0,0,180*sin($t*360)])
BottomMesh();

LeadScrew();

rotate([0,0,$t*360])
Pole();

rotate([0,0,$t*360])
translate([0,0,10-10*sin($t*360)])
UpperCarrage();

