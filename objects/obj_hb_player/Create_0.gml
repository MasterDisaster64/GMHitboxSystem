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

sword_obj = instance_create_depth(0, 0, 0, obj_hb_empty_object)
sword_obj.mask_index = spr_hb_sword
sword_hbox = new Hitbox(new HitboxObjectShape(sword_obj), obj_hb_enemy, new SingleHitTracker())
on_sword_hit = function(_hit_obj) {
    do_damage(_hit_obj, 20)
    _hit_obj.knock_back(4 * sign(_hit_obj.x - x), -12)
}
sword_spin_rate = 10