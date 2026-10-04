var move_input = 0 - keyboard_check(vk_left) + keyboard_check(vk_right)
hspeed = move_input * move_speed
if (move_input != 0) image_xscale = sign(move_input)

x = clamp(x, 0, room_width)
var is_grounded = y >= global.floor_height
if is_grounded {
    y = global.floor_height
    vspeed = 0
}

if is_grounded and keyboard_check(vk_space)
    vspeed = -jump_speed