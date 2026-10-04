move_speed = 4
gravity = 0.5
jump_speed = 10

spear_hbox = new Hitbox(new HitboxRect(48, 0, 64, 8), obj_hb_enemy)
on_spear_hit = function(_hit_obj) {
    do_damage(_hit_obj, 5)
    _hit_obj.knock_back(4 * image_xscale, 0)
}