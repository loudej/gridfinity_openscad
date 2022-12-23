include <gridfinity_modules.scad>
include <modules/brother-p-touch-tz-tze-label-tape-holder.scad>

cup_height = 5;
stick_diameter = 30;
easement_z = 0.7; // a slightly large opening at the top for compliance while inserting.
minimum_wall = 4;
blocks_needed = ceil((stick_diameter+2*minimum_wall)/gridfinity_pitch);

render()
// glue_stick_cup(blocks_needed, blocks_needed, cup_height);
brother_tz_tape();

module brother_tz_tape() {
    grid_block(5, 4, 1, screw_depth=0, center=false);
    translate([-10, -14, +5])
        brother_tse_case(5, cas_width=cas_width_24mm);
    translate([+85, -14, +5])
        brother_tse_case(8, cas_width=cas_width_12mm);
}

module glue_stick_cup(num_x=1, num_y=1, num_z=2) {
  difference() {
    grid_block(num_x, num_y, num_z, magnet_diameter=0, screw_depth=0, center=true);
    glue_stick(num_z, stick_diameter);
  }
}

module glue_stick(num_z=5, diam) {
  floor_thickness = blocks_needed > 1 ? 5.5 : 1.2;
  translate([0, 0, floor_thickness]) cylinder(h=num_z*gridfinity_zpitch, d=diam);
  translate([0, 0, (num_z - easement_z)*gridfinity_zpitch + 1.2]) 
    cylinder(h=easement_z*gridfinity_zpitch, d1=diam, d2=diam*1.1);
}
