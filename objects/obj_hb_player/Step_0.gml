#region Movement

var is_grounded = y >= global.floor_height
if is_grounded {
    y = global.floor_height
    vspeed = 0
}

x = clamp(x, 0, room_width)

#endregion

#region Combat

if keyboard_check(ord("A")) {
    // Shared tracker + order of trigger calls ensures an enemy can only be hit by the point if it's NOT hit by the shaft
    // If the order were reversed, the point would take priority over the shaft
    spear_shaft_hbox.trigger()
    spear_point_hbox.trigger()
    array_foreach(spear_shaft_hbox.hit_targets, on_spear_shaft_hit)
    array_foreach(spear_point_hbox.hit_targets, on_spear_point_hit)
    
    hspeed = 0
}

#endregion

#region More movement

else {
   var move_input = 0 - keyboard_check(vk_left) + keyboard_check(vk_right)
   hspeed = move_input * move_speed
   if (move_input != 0) image_xscale = sign(move_input)
   
   if is_grounded and keyboard_check(vk_space)
       vspeed = -jump_speed
}

#endregion
