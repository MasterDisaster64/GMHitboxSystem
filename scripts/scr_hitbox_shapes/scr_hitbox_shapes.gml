/// @desc The base class for hitbox shapes. Not intended to be used on its own.
function HitboxShape() constructor {
    /// @desc Performs a collision check and adds the results to the end of a list.
    /// @param {Id.TileMapElement|Asset.GMObject|Id.Instance|Constant.All|Constant.Other|Array} _target What can be hit by the hitbox.
    /// @param {Id.List} _list The list to add the results to.
    /// @return {Real} The number of objects touched by the shape.
    static trigger = function(_target, _list) {}
    
    /// @desc Draws the shape for debugging purposes.
    static draw = function() {}
}

/// @desc A shape defined as an axis-aligned rectangle.
/// @param {Real} _x X coordinate of the rectangle center.
/// @param {Real} _y Y coordinate of the rectangle center.
/// @param {Real} _width Width of the rectangle.
/// @param {Real} _height Height of the rectangle.
/// @param {Id.Instance} _relative_to The instance that the shape's coordinates are relative to. Defaults to `other`, i.e. the one calling the constructor. Can also be set to `noone` for absolute coordinates.
function HitboxRect(_x, _y, _width, _height, _relative_to = other) : HitboxShape() constructor {
    x = _x; y = _y
    half_width = _width * 0.5
    half_height = _height * 0.5
    relative_to = _relative_to
    
    static trigger = function(_target, _list) {
        var center_x = x, center_y = y
        if relative_to != noone {
            center_x *= relative_to.image_xscale
            center_x += relative_to.x
            center_y += relative_to.y
        }
        
        return collision_rectangle_list(
            center_x - half_width, center_y - half_height,
            center_x + half_width, center_y + half_height,
            _target, false, true, _list, false
        )
    }
    
    static draw = function() {
        var center_x = x, center_y = y
        if relative_to != noone {
            center_x *= relative_to.image_xscale
            center_x += relative_to.x
            center_y += relative_to.y
        }
        
        set_hitbox_draw_options()
        draw_rectangle(
            center_x - half_width, center_y - half_height,
            center_x + half_width, center_y + half_height,
            false
        )
    }
}

/// @desc A shape defined as a circle.
/// @param {Real} _x X coordinate of the circle center.
/// @param {Real} _y Y coordinate of the circle center.
/// @param {Real} _radius Radius of the circle.
/// @param {Id.Instance} _relative_to The instance that the shape's coordinates are relative to. Defaults to `other`, i.e. the one calling the constructor. Can also be set to `noone` for absolute coordinates.
function HitboxCircle(_x, _y, _radius, _relative_to = other) : HitboxShape() constructor {
    x = _x; y = _y
    radius = _radius
    relative_to = _relative_to
    
    static trigger = function(_target, _list) {
        var center_x = x, center_y = y
        if relative_to != noone {
            center_x *= relative_to.image_xscale
            center_x += relative_to.x
            center_y += relative_to.y
        }
        
        return collision_circle_list(
            center_x, center_y, radius,
            _target, false, true, _list, false
        )
    }
    
    static draw = function() {
        var center_x = x, center_y = y
        if relative_to != noone {
            center_x *= relative_to.image_xscale
            center_x += relative_to.x
            center_y += relative_to.y
        }
        
        set_hitbox_draw_options()
        draw_circle(center_x, center_y, radius, false)
    }
}

/// @desc A shape that uses the collision mask of a specific object instance. Useful for contact damage or complex hitboxes with rotation, precise sprite collisions etc.
/// @param {Id.Instance} _instance The instance to use for collision. Defaults to `other`, i.e. the one calling the constructor.
function HitboxObjectShape(_instance = other) : HitboxShape() constructor {
    instance = _instance
    
    static trigger = function(_target, _list) {
        with instance {
            return instance_place_list(x, y, _target, _list, false)
        }
    }
    
    static draw = function() {
        var sprite = instance.mask_index == -1 ? instance.sprite_index : instance.mask_index;
        set_hitbox_draw_options()
        with instance {
          draw_sprite_ext(
              sprite, image_index,
              x, y, image_xscale, image_yscale, image_angle,
              draw_get_colour(), draw_get_alpha()
          )
        }
    }
}


/// @desc A shape consisting of several other shapes.
/// @param {Array<Struct.HitboxShape>} _subshapes The shapes that make up this shape
function HitboxCompositeShape(_subshapes) : HitboxShape() constructor {
    subshapes = _subshapes
    
    static trigger = function(_target, _list) {
        var i = 0, sum = 0
        repeat (array_length(subshapes)) {
        	sum += subshapes[i++].trigger(_target, _list)
        }
        return sum
    }
    
    static draw = function() {
        var i = 0
        repeat (array_length(subshapes)) {
        	subshapes[i++].draw()
        }
    }
}

