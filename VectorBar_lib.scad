
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
module ColorBars(pointList){
    colors = ["red", ,"orange", "yellow", "green", "cyan", "blue", "violet", "purple"];
    numCol = len(colors);
    length = len(pointList);
    for(i=[0:1:len(pointList)-2]){
        color(colors[i/(length/numCol)])
        Bar(pointList[i],pointList[i+1]);
    }
}
