text = "Text"
color = c_white
vspeed = -1

destroy_timer = time_source_create(
    time_source_game, 2, time_source_units_seconds,
    method(self, instance_destroy)
)
time_source_start(destroy_timer)