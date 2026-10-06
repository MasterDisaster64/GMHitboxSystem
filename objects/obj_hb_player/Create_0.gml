move_speed = 4
gravity = 0.5
jump_speed = 10

/// Spear shaft and tip share one tracker
spear_shaft_hbox = new Hitbox(
    new HitboxRect(48, 0, 64, 8),
    global.player_hbox_target,
    new RepeatHitTracker()
)
spear_point_hbox = new Hitbox(
    new HitboxRect(88, 0, 16, 16),
    global.player_hbox_target,
    spear_shaft_hbox.tracker
)
on_spear_shaft_hit = function(_hit_obj) {
    do_damage(_hit_obj, 5)
    _hit_obj.knock_back(6 * image_xscale, 0)
}
on_spear_point_hit = function(_hit_obj) {
    do_damage(_hit_obj, 20, make_colour_rgb(0, 255, 0))
    _hit_obj.knock_back(6 * sign(_hit_obj.x - x), -10)
}

sword_obj = instance_create_depth(0, 0, 0, obj_hb_empty_object)
sword_obj.mask_index = spr_hb_sword
sword_frames_left = 0
sword_direction = 0
sword_hbox = new Hitbox(
    new HitboxObjectShape(sword_obj),
    global.player_hbox_target
)
on_sword_hit = function(_hit_obj) {
    do_damage(_hit_obj, 10)
    _hit_obj.knock_back(4 * image_xscale, -12)
}