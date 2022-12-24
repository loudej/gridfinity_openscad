include <gridfinity_modules.scad>


module drill_holder(num_x=1, back_widths=[], front_widths=[], name="", num_z=3,
    label_height = 12.7, side_margin=3, back_support_angle = 10, bit_extra_space = 0.7,
    back_bump_height=21,
    front_bump_height=9
) {
    full_w = 42*num_x - .5;
    usable_w = full_w - (side_margin * 2);
    back_y_offset = 0;
    front_margin = 4;
    back_margin = 2;
    label_side_margin = 4;
    back_label_side_margin = 1;
    left_start = -20.75;
    corner_radius=3.7;
    label_thickness=0.5;
    difference() {
    union() {
        grid_block(num_x, 1, num_z);
        // back row back support
        rotate([-back_support_angle,0,0])translate([left_start,back_y_offset-5,20])
            cube([full_w,10,45]);
        // back row bump
        rotate([-back_support_angle,0,0])translate([left_start,back_y_offset-12,19])
            cube([full_w,11,back_bump_height]);
        
        // front row bump
        translate([left_start,-17,19])
            cube([full_w,15,front_bump_height]);
        translate([left_start+corner_radius,corner_radius-20.76,19])
            cylinder(r=corner_radius,h=front_bump_height, $fa=1, $fs=.8);
        translate([full_w+left_start-corner_radius,corner_radius-20.76,19])
            cylinder(r=corner_radius,h=front_bump_height, $fa=1, $fs=.8);
        translate([left_start+corner_radius,left_start,19])
            cube([full_w-(corner_radius*2),15,front_bump_height]);
    }
    // back drills
    rotate([-back_support_angle,0,0])translate([left_start + side_margin,back_y_offset,7])
      drills(inc(back_widths,bit_extra_space), usable_w);
    // front drills
    rotate([0,0,0])translate([left_start + side_margin + 2,-8,7])
      drills(inc(front_widths,bit_extra_space), usable_w - 4);
    // back label window
    rotate([-back_support_angle,0,0])translate([left_start + back_label_side_margin,back_margin-14.05,back_bump_height+5.6])
        cube([full_w - (back_label_side_margin * 2),label_thickness,label_height]);
    // front label window
    translate([left_start + label_side_margin,left_start-.01,max(front_bump_height+5.5,11)])
        cube([full_w - (label_side_margin * 2),label_thickness,label_height]);
  //  translate([-18,-20,10])rotate([90,0,0])
  //    linear_extrude(10)text(name);
   // translate([-18,-18,22])cube([usable_w,42-6,50]);
  }
}

function inc(v, a=.6) = [for (i = v) i+a ];
function move(v, i=0, r=0, lo=0) = i > 0 ? move(v, i-1, r+(v[i-1]+v[i])/2, lo) + lo : r;
function sum(v, i=0, r=0) = i < len(v) ? sum(v, i+1, v[i] + r) : r;
// inches to mm
function in(v) = v * 25.4;

module drills(widths=[], width = 100) {
  leftover = width - sum(widths);
  echo(leftover=leftover, "(should be greater than 0)");
  for (i = [0:len(widths)-1]) {
    s = move(widths, i, 0, leftover/(len(widths)-1));
    translate([widths[0]/2,0,0])
    translate([s,-5,0])cylinder(h=70, d=widths[i], $fs=0.8);
  }
}

function reverse(input) = [ for (i = [len(input)-1 : -1 : 0]) input[i] ];
