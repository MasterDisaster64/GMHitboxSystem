move_speed = 4
gravity = 0.5
jump_speed = 10

/// Spear shaft and tip share one tracker
spear_shaft_hbox = new Hitbox(new HitboxRect(48, 0, 64, 8), obj_hb_enemy)
spear_point_hbox = new Hitbox(new HitboxRect(80, 0, 16, 16), obj_hb_enemy, spear_shaft_hbox.tracker)
on_spear_shaft_hit = function(_hit_obj) {
    do_damage(_hit_obj, 5)
    _hit_obj.knock_back(4 * image_xscale, 0)
}
on_spear_point_hit = function(_hit_obj) {
    do_damage(_hit_obj, 10, make_colour_rgb(0, 255, 0))
    _hit_obj.knock_back(6 * image_xscale, -8)
    
}