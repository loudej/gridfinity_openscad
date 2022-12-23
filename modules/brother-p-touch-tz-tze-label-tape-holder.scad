/** *** ***** ******* ***********
//
// Brother P-Touch TZ TZe Label Tape Holder
// Version 1 - 11.12.2022
// CC-BY-NC-SA 2022 by andrej@kyselica.com (Andrej Kyselica)
//
// Based on:
//
// Brother P-Touch TZ TZe Label Tape Holder
// Version 1 - 07.08.2020 
// CC-BY-NC-SA 2020 by oli@huf.org (ohuf@Thingiverse)
//
// www.thingiverse.com/thing:


** *** ***** ******* ***********/




cas_width_12mm=18;  //orig: 17
cas_width_24mm=29;

// brother_tse_case(5, cas_width=cas_width_24mm);
// brother_tse_case(5, cas_width=cas_width_12mm);


module brother_tse_case(slots=9, cas_width=cas_width_12mm) {
    $fn=360;
    
    dt1=0.01;
    dt2=dt1*2;
    prt_delta=0.4;

    cas_x=89; 
   
    cas_y=cas_width; 
    cas_z=67-15;

    mat=1.2;

    // parameters for the clip
    //$fn= 360;
    cl_w = cas_y*.8;       // width of rectangle
    cl_h = mat;       // height of rectangle
    cl_l = 23;      // length of chord of the curve
    cl_dh = 1;           // delta height of the curve

    cut_z=25; // orig 25
    cut_dz=cl_l+1;

    for(i=[0:slots-1]){
    translate([0, i*(cas_y+mat), 0])
    union(){
        difference(){
            union(){
                cube([cas_x+mat*2, cas_y+mat*2, cas_z+mat]);
            }
            union(){
                // cassette cutout
                translate([mat, mat, mat+dt1])
                color("grey")
                cube([cas_x, cas_y, cas_z]);
                
                // pin-cutout
                translate([45+mat, -dt1, 18])
                color("blue")
                cube([16, cas_y+2*mat+dt2, 51 ]);

                // Label-Cutout:
                translate([33, -dt1, 41+mat+dt1])
                color("blue")
                cube([28, cas_y+2*mat+dt2, 28 ]);

    //			// Test-Cutout:
    //			translate([15, -dt1, cas_z-38+mat+dt1])
    //			color("blue")
    //			cube([62, cas_y+2*mat+dt2, 38 ]);
                
                //clip1 cutout
                translate([-dt1, mat, cut_z])
                color("blue")
                cube([mat+dt2, cas_y, cl_l+1 ]);

                //clip2 cutout
                translate([cas_x+mat-dt1, mat, cut_z])
                color("blue")
                cube([mat+dt2, cas_y, cl_l+1 ]);
            }
        }



        //Clip 1:
        //translate([cl_dh/2, cas_y*.2/2+mat, cut_z-cl_l/2-1])
        translate([(cl_h)/2, cas_y*.2/2+mat, cut_z+cl_l/2-0.2])
        union(){
            difference(){
                rotate([90, 0, 0])
                color("green")
                curve(cl_w, cl_h, cl_l, cl_dh);
                
                translate([-(cl_h/2+dt1), (cl_w-3)/2, -cl_l/2+1.5])
                color("red")
                cube([cl_h+cl_dh+dt2, 3, cl_l-3+dt2]);
            }
        //	translate([-(dt1+cl_h/2),(cl_w-3)/2, -cl_l/2+1.5])
        //	color("pink")
        //	cube([cl_h+cl_dh+dt2, 3, cl_l-3+dt2]);
        }
        //		translate([cas_x+mat-dt1, mat, cut_z-(cl_l)])
        //Clip 2:
        translate([cas_x+mat+cl_h/2, cas_y-cas_y*.2/2+mat, cut_z+cl_l/2-0.2])
        rotate([0,0,180])
        difference(){
            rotate([90, 0, 0])
            color("green")
            curve(cl_w, cl_h, cl_l, cl_dh);
            
            translate([-(cl_h/2+dt1), (cl_w-3)/2, -cl_l/2+1.5])
            color("red")
            cube([cl_h+cl_dh+dt2, 3, cl_l-3+dt2]);
        }
    }
    }
}


// this is from: https://stackoverflow.com/a/54135051
module curve(width, height, length, dh) {
    r = (pow(length/2, 2) + pow(dh, 2))/(2*dh);
    a = 2*asin((length/2)/r);
    translate([-(r -dh), 0, -width/2]) rotate([0, 0, -a/2])         rotate_extrude(angle = a) translate([r, 0, 0]) square(size = [height, width], center = true);
}



//$fn= 360;
//
//width = 10;   // width of rectangle
//height = 2;   // height of rectangle
//r = 50;       // radius of the curve
//a = 30;       // angle of the curve
//
//rotate_extrude(angle = a) translate([r, 0, 0]) square(size = [height, width], center = true);
