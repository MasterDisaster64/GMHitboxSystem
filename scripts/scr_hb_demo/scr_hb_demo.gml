global.player_hbox_target = obj_hb_enemy
global.enemy_hbox_target = obj_hb_player

global.player_aoe_tracker = new ContinuousHitTracker()

function do_damage(_instance, _amount, _text_color = c_white) {
    var text_obj = instance_create_depth(random_range(_instance.bbox_left, _instance.bbox_right), _instance.bbox_top, -10, obj_hb_floating_text)
    text_obj.text = _amount
    text_obj.color = _text_color
}

function on_enemy_projectile_hit(_hit_obj) {
    do_damage(_hit_obj, 20, c_red)
    instance_destroy(self)
}