//consts
mmPIn = 25.4;
difShft=1;

outerX = mmPIn*11;
outerY = mmPIn*15;
outerZ = mmPIn*8.5;
wallWidth = mmPIn*.5;

handY = mmPIn*.25;
handZ = mmPIn*2;
handX = 2*handZ;

module handle2(){
    //removed -handY/2 now lines up with edge
    translate([0, outerY/2+difShft/2, handZ])
    rotate([90,0,0])
    linear_extrude(height=handY)
    difference(){  
        circle(handZ);
        translate([0, handZ/2,0])
        square([2*handZ,handZ],center=true);
    }
}

module handle(){

    translate([0, outerY/2-handY/2+difShft/2, 0])
    cube([handX,handY+difShft,handZ],center=true);
}

module inside(){
    translate([0, 0, difShft/2+wallWidth/2])
    cube([outerX-2*wallWidth, outerY-2*wallWidth, outerZ+difShft-wallWidth],center=true);
}
module main(){
    translate([0,0,outerZ/2])
    difference() {
        cube([outerX,outerY,outerZ],center=true);
        inside();
        handle2();
        mirror([0,1,0])
        handle2();
    }
}

main();

