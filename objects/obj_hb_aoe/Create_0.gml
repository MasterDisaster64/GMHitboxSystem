// Create a hitbox that hits continuously
// Since all AoEs share a tracker, their effect doesn't stack
hbox = new Hitbox(
    new HitboxCircle(0, 0, 128),
    global.player_hbox_target,
    global.player_aoe_tracker
)
on_hit = function(_hit_obj) {
    do_damage(_hit_obj, 1)
    _hit_obj.is_slowed = true
}

destroy_timer = time_source_create(
    time_source_game, 2, time_source_units_seconds,
    method(self, instance_destroy)
)
time_source_start(destroy_timer)