move_speed = 4
gravity = 0.5

contact_hbox = new Hitbox(new HitboxObjectShape(), obj_hb_character)
on_contact = function(_hit_obj) {
    show_debug_message("{0}: Ouch! {1}", _hit_obj, global.hb_frame)
}