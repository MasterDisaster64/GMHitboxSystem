global.hb_temp_list = ds_list_create()

/// @param {Struct.HitboxShape} _shape Defines the area the hitbox covers.
/// @param {Id.TileMapElement|Asset.GMObject|Id.Instance|Constant.All|Constant.Other|Array} _target What can be hit by the hitbox.
/// @param {Struct.HitTracker} _tracker Controls when targets touched by the shape are considered hit. A set of hitboxes sharing a tracker won't hit an object at the same time. Defaults to a new tracker unique to this hitbox.
function Hitbox(_shape, _target = noone, _tracker = new SingleHitTracker()) constructor {
    shape = _shape
    target = _target
    tracker = _tracker
    
    hit_targets = []
    
    /// @desc Performs a collision check defined by the `shape` and stores newly hit targets in `hit_targets`.
    /// @param {Id.TileMapElement|Asset.GMObject|Id.Instance|Constant.All|Constant.Other|Array} _target Lets you override the hitbox's default target.
    /// @return {Struct.Hitbox} The hitbox itself, for method chaining.
    static trigger = function(_target = target) {
        var no_tracker = tracker == pointer_null
        if !no_tracker tracker.prepare()
        array_clear(hit_targets)
        ds_list_clear(global.hb_temp_list)
        var touched_count = shape.trigger(_target, global.hb_temp_list)
        
        var i = 0
        repeat (touched_count) {
            var touched_obj = global.hb_temp_list[| i++]
            
            // Check if the object has any extra conditions to be hit
            // We do this via a try/catch for maximum performance without always needing a method defined,
            // though this can can cause errors inside the method to go unnoticed
            try {
            	if !touched_obj.hb_can_hit() continue
            }
            catch (e) {
                // If you get bugs related to vulnerability,
                // uncomment the code below and see if you get any other unhandled exceptions
                //show_debug_message(_exception.message);
                //show_debug_message(_exception.longmessage);
                //show_debug_message(_exception.script);
                //show_debug_message(_exception.stacktrace);
            }
            
            if no_tracker || tracker.register(touched_obj)
                array_push(hit_targets, touched_obj)
        }
        
        return self
    }
    
    /// @desc Executes a function for each target the hitbox hit when last triggered.
    /// Executes in the existing scope, not the hitbox's.
    /// @param {Function} _function The callback function to perform for each hit target. Accepts the following arguments: (value, index).
    static foreach = function(_function) {
        with other array_foreach(other.hit_targets, _function)
    }
    
    /// @desc Checks whether a given function returns true for any target the hitbox hit when last triggered.
    /// Executes in the existing scope, not the hitbox's.
    /// @param {Function} _function The predicate function to perform for each hit target. Accepts the following arguments: (value, index) and should return a bool).
    static any = function(_function) {
        with other return array_any(other.hit_targets, _function)
    }
    
    /// @desc Returns the number of targets the hitbox hit when last triggered.
    static hit_count = function() {
        return array_length(hit_targets)
    }
    
    /// @desc Returns whether the hitbox hit anything when last triggered.
    static hit_anything = function() {
        return hit_count() > 0
    }
    
    /// @desc Draws the hitbox for debugging purposes.
    static draw = function() {
        shape.draw()
    }
}