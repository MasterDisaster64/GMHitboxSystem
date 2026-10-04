move_speed = 4
gravity = 0.5

contact_hbox = new Hitbox(new HitboxObjectShape(), obj_hb_character)
on_contact = function(_hit_obj) {
    do_damage(_hit_obj, 5, c_red)
}