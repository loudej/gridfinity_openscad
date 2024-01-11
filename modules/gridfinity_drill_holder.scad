include <gridfinity_modules.scad>

module drill_holder(num_x=1, back_widths=[], front_widths=[], name="", num_z=3,
    label_height = 12.7, side_margin=3, back_support_angle = 10, bit_extra_space = 0.7,
    back_bump_height=21,
    front_bump_height=9,
    back_numerators=[],
    back_denominators=[],
    front_numerators=[],
    front_denominators=[],
    show_holder=true,
    show_labels=false,
    text_size=4,
    text_font="Overpass:style=SemiBold"
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
    if (show_holder) difference() {
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
      rotate([-back_support_angle,0,0])translate([left_start + side_margin,back_y_offset+1.5,7])
        drills(inc(back_widths,bit_extra_space), usable_w);
      // front drills
      rotate([0,0,0])translate([left_start + side_margin ,-8,7])
        drills(inc(front_widths,bit_extra_space), usable_w );
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

    if (show_labels) {
    // back row label
    translate([left_start, -42, 0])
    union() {
      // labels is horizontally aligned with "back drills"
      translate([side_margin, 0, 0])
      labels(back_numerators, inc(back_widths,bit_extra_space),
        text_size=text_size, text_font=text_font,
        text_offset=[0,+text_size/4], halign="center", valign="baseline",
        plate_size=[usable_w , label_height, label_thickness*2]);

      translate([side_margin, 0, 0])
      labels(back_denominators, inc(back_widths,bit_extra_space),
        text_size=text_size, text_font=text_font,
        text_offset=[0,-text_size/4], halign="center", valign="top",
        plate_size=[usable_w , label_height, label_thickness*2]);

      // plate is horizontally aligned with "back label window"
      translate([back_label_side_margin, 0, 0]) 
      cube([full_w - (back_label_side_margin * 2), label_height, label_thickness*2]);
    }

    // front row label
    translate([left_start, -42 - label_height - 4, 0])
    union() {
      // labels is horizontally aligned with "front drills"
      translate([side_margin, 0, 0])
      labels(front_numerators, inc(front_widths,bit_extra_space),
        text_size=text_size, text_offset=[0,+text_size/4], halign="center", valign="baseline",
        plate_size=[usable_w , label_height, label_thickness*2]);

      translate([side_margin, 0, 0])
      labels(front_denominators, inc(front_widths,bit_extra_space),
        text_size=text_size, text_offset=[0,-text_size/4], halign="center", valign="top",
        plate_size=[usable_w , label_height, label_thickness*2]);

      // plate is horizontally aligned with "front label window"
      translate([label_side_margin, 0, 0]) 
      cube([full_w - (label_side_margin * 2), label_height, label_thickness*2]);
    }
  }
}

function inc(v, a=.6) = [for (i = v) i+a ];
// inches to mm
function in(v) = v * 25.4;

function _sum(v, i, r) = (i == len(v)) ? r : _sum(v, i+1, r + v[i]);
function sum(v) = _sum(v, 0, 0);

function _hcenter(v, n, pad, i, r) = (i == n) ? (r + pad/2 + v[i]/2) : _hcenter(v, n, pad, i+1, r + pad + v[i]);
function hcenter(v, n, pad=0) = _hcenter(v, n, pad, 0, 0);
function hcenters(v, pad=0) = [for (n=[0:len(v)-1]) _hcenter(v, n, pad, 0, 0)];

function imperial_widths(numerators=[], denominators=[]) = [for (i=[0:len(numerators)-1]) in(numerators[i] / denominators[i])];

module drills(widths=[], width = 100) {
  leftover = width - sum(widths);
  echo(leftover=leftover, "(should be greater than 0)");
  for (i = [0:len(widths)-1]) {
    s = hcenter(widths, i, leftover/len(widths));
    translate([s,-5,0])cylinder(h=70, d=widths[i], $fs=0.8);
  }
}

module labels(numerators=[], widths=[], 
  text_size=4.5, text_font="Overpass:style=SemiBold", 
  halign="center", valign="center", text_offset=[0,0],
  plate_size=[100, 12.7, 1]) {
  leftover = plate_size[0] - sum(widths);
  centers = hcenters(widths, leftover/len(widths));

  echo(leftover=leftover, "(should be greater than 0)");
  union() {
    for (i = [0:len(widths)-1]) {
      translate([text_offset[0],text_offset[1],0])
      translate([centers[i],plate_size[1]/2,plate_size[2]])
      linear_extrude(0.6)
      text(str(numerators[i]), size=text_size, halign=halign, valign=valign, font="Overpass:style=SemiBold");

      translate([centers[i],plate_size[1]/2,plate_size[2]])
      //rotate([0, 0, 22.5])
      translate([-text_size/2, -0.3, 0])
      cube([text_size, 0.6, 0.6]);
    }
  }
}

function reverse(input) = [ for (i = [len(input)-1 : -1 : 0]) input[i] ];
