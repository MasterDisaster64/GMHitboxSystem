#region Movement

var is_grounded = y >= global.floor_height
if is_grounded {
    y = global.floor_height
    vspeed = 0
}

x = clamp(x, 0, room_width)

#endregion

if keyboard_check(ord("A")) {
    spear_hbox.trigger()
    array_foreach(spear_hbox.hit_targets, on_spear_hit)
    
    hspeed = 0
}
else {
   var move_input = 0 - keyboard_check(vk_left) + keyboard_check(vk_right)
   hspeed = move_input * move_speed
   if (move_input != 0) image_xscale = sign(move_input)
   
   if is_grounded and keyboard_check(vk_space)
       vspeed = -jump_speed
}