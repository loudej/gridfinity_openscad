include <modules/gridfinity_drill_holder.scad>

show_holder=true;
show_labels=false;

back_numerators =   [  1,  3,  5,  1,  7,  3];
back_denominators = [  2,  8, 16,  4, 32, 16];

front_numerators =   [  1,  5,  3,  7,  1,  1,  9,  5];
front_denominators = [ 16, 64, 32, 64,  8,  8, 64, 32];

/*
echo("sum 1,2,3", sum([1,2,3]));
echo("hcenters 1,2,3", hcenters([1,2,3]));

echo("hcenters 1,2,3 +20", hcenters([1,2,3], 20));

echo("hcenters 1", hcenters([1]));
echo("hcenters 2", hcenters([2]));
echo("hcenters 1,1", hcenters([1,2]));

echo("hcenter 1,1 (0)", hcenter([1,1],0));
echo("hcenter 1,1 (1)", hcenter([1,1],1));
echo("hcenter 1,2,3 (0)", hcenter([1,2,3],0));
echo("hcenter 1,2,3 (1)", hcenter([1,2,3],1));
echo("hcenter 1,2,3 (2)", hcenter([1,2,3],2));
*/

drill_holder(2, 
    back_numerators=back_numerators,
    back_denominators=back_denominators,
    back_widths=imperial_widths(back_numerators, back_denominators), 
    front_numerators=front_numerators,
    front_denominators=front_denominators,
    front_widths=imperial_widths(front_numerators, front_denominators),
    show_holder=show_holder,
    show_labels=show_labels
);

// Metric Taps (Amazon: https://a.co/d/1dbat21) 
// drill_holder(-1, [9.9, 7.9, 6.1, 5.9], reverse([4.9, 4.8, 3.9, 3.0, 2.9]), side_margin=1);

// Metric drills
// drill_holder(0, [10, 9.5, 9, 8.5, 8, 7.5, 7], reverse([6.5, 6, 5.5, 5, 4.5, 4, 3.5, 3, 2.5, 2, 1.5, 1]), "");
