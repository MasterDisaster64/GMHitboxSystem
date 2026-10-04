#region Movement

var is_grounded = y >= global.floor_height
if is_grounded {
    y = global.floor_height
    if vspeed > 0 vspeed = 0
}

x = clamp(x, 0, room_width)

if is_knocked_back {
    if x == 0 hspeed = abs(hspeed)
    else if x == room_width hspeed = -abs(hspeed)
        
    if is_grounded {
      if hspeed = 0
          is_knocked_back = false
      else if abs(hspeed) < knockback_friction
          hspeed = 0
      else
          hspeed -= knockback_friction * sign(hspeed)
    }
}
else {
    if x == 0 image_xscale = 1
    else if x == room_width image_xscale = -1
        
    if random(240) <= 1 image_xscale = -image_xscale
    hspeed = move_speed * image_xscale
}

#endregion

#region Combat

contact_hbox.trigger()
array_foreach(contact_hbox.hit_targets, on_contact)

#endregion