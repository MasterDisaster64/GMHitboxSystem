global.hb_temp_list = ds_list_create()

/// @param {Struct.HitboxShape} _shape Controls what the hitbox covers
/// @param {Id.TileMapElement|Asset.GMObject|Id.Instance|Constant.All|Constant.Other|Array} _target What can be hit by the hitbox
/// @param {Struct.HitTracker} _tracker Struct that keeps track of what the hitbox is touching. Defaults to a new tracker unique to this hitbox.
function Hitbox(_shape, _target, _tracker = new HitTracker()) constructor {
    shape = _shape
    target = _target
    tracker = _tracker
    
    hit_targets = [] // The targets that were hit
    
    /// @desc Performs a collision check defined by the `shape` and performs the `on_hit` function with newly hit targets.
    static trigger = function() {
        array_clear(hit_targets)
        ds_list_clear(global.hb_temp_list)
        var touched_count = shape.trigger(target, global.hb_temp_list)
        
        var i = 0
        repeat (touched_count) {
            var touched_obj = global.hb_temp_list[| i++]
            if tracker.register(touched_obj)
                array_push(hit_targets, touched_obj)
        }
    }
    
    /// @desc Returns the number of targets that were hit last time the hitbox triggered.
    static hit_count = function() {
        return array_length(hit_targets)
    }
    
    /// @desc Draws the hitbox for debugging purposes.
    static draw = function() {
        shape.draw()
    }
}