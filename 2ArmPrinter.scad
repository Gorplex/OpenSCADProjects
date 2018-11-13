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


module key(){
    
}



difference(){
    cylinder(PoleZ, d=PoleDia, true);
    translate([0,0,-difShift])
    cylinder(PoleZ+2*difShift, d=CarrageDia+2*CarrageClear, true);
    translate([CarrageDia/2+CarrageClear+difShift,0,PoleZ/2])
    cube([(PoleDia-CarrageDia)/2+CarrageClear+2*difShift,SlotWidth+SlotClear,PoleZ+2*difShift], true);
}


translate([0,0,/*10*$t*/-CarrageZ-2])

    cylinder(CarrageZ, d=CarrageDia, true);
