var is_grounded = y >= global.floor_height
if is_grounded {
    y = global.floor_height
    vspeed = 0
}

if x < 0 {
    x = 0
    image_xscale = 1
}
else if x > room_width {
    x = room_width
    image_xscale = -1
}
hspeed = move_speed * image_xscale