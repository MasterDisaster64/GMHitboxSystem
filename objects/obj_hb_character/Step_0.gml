#region Movement

var is_grounded = y >= global.floor_height
if is_grounded {
    y = global.floor_height
    vspeed = 0
}

x = clamp(x, 0, room_width)

var move_input = 0 - keyboard_check(vk_left) + keyboard_check(vk_right)
hspeed = move_input * move_speed
if (move_input != 0) image_xscale = sign(move_input)

if is_grounded and keyboard_check(vk_space)
    vspeed = -jump_speed

#endregion

if keyboard_check(ord("A")) {
    spear_hbox.trigger()
    var i = 0
    repeat (array_length(spear_hbox.hit_targets)) {
    	var hit_obj = spear_hbox.hit_targets[i++]
        hit_obj.knock_back(5 * image_xscale, -10)
    }
}