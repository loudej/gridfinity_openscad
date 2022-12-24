include <modules/gridfinity_drill_holder.scad>

// Milwaukee drill set 
drill_holder(2, 
    [in(1/8), in(5/16), in(9/32), in(1/4), in(7/32), in(13/64), in(3/16)], 
    reverse([in(9/64), in(5/32), in(9/64), in(1/8), in(7/64), in(3/32), in(5/64), in(1/16)]), 
    "");

// Metric Taps (Amazon: https://a.co/d/1dbat21) 
// drill_holder(-1, [9.9, 7.9, 6.1, 5.9], reverse([4.9, 4.8, 3.9, 3.0, 2.9]), side_margin=1);

// Metric drills
// drill_holder(0, [10, 9.5, 9, 8.5, 8, 7.5, 7], reverse([6.5, 6, 5.5, 5, 4.5, 4, 3.5, 3, 2.5, 2, 1.5, 1]), "");
