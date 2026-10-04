move_speed = 4
gravity = 0.5
knockback_friction = 0.25

is_knocked_back = false

contact_hbox = new Hitbox(new HitboxObjectShape(), obj_hb_character)
on_contact = function(_hit_obj) {
    do_damage(_hit_obj, 10, c_red)
}

knock_back = function(_hspeed, _vspeed) {
    is_knocked_back = true
    hspeed = _hspeed
    vspeed = _vspeed
}

