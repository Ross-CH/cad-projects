
width = 14;
length = 14;
height = 3;

for (i = [0:19:19*12]){
    for (j = [0:19:19*5]){
        translate([i, j, 0]){
            difference() {
                cube([19,19,2], center=true);
                cube([width,length,height], center=true);
                translate([0,4.25,0]){
                    cube([15,3.5,height],center=true);
                }
                translate([0,-4.25,0]){
                    cube([15,3.5,height],center=true);
                }
            }
        }
    }
}

