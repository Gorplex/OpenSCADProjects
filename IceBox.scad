//consts
mmPIn = 25.4;
difShft=100;

outerX = mmPIn*11;
outerY = mmPIn*15;
outerZ = mmPIn*8.5;
wallWidth = mmPIn*.5;

module handle(){
    handY = .25;
    handY
    handZ
    translate([0, outerY/2-mmPIn*handDepth+difShft/2, 0])
    cube(mmPIn*[4,handDepth+difShft,2],center=true);
}


difference() {
    cube([outerX,outerY,outerZ],center=true);
    translate([0, 0, difShft/2])
    cube([outerX-2*wallWidth, outerY-2*wallWidth, outerZ+difShft-2*wallWidth],center=true);
    handle();
}


