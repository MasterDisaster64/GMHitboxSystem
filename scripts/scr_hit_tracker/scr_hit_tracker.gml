/// @desc Struct used by hitboxes to keep track of what they're touching. A set of hitboxes sharing a tracker won't hit an object at the same time - good for e.g. attacks with sweet spots.
function HitTracker() constructor {
    touched_objs = []
    
    /// @desc Registers an object as having been touched this frame, and returns whether it should be considered a new hit.
    /// @param {Any} _touched_obj The object to attempt to register.
    /// @return {Bool} Whether the object was considered "hit".
    static register = function(_touched_obj) {}
    
    /// @desc Prepares the tracket to be used this frame. Call this before attempting to register anything.
    static prepare = function() {}
}

function RepeatHitTracker() : HitTracker() constructor {
    prev_touched_objs = []
    frame_last_used = 0
    
    static register = function(_touched_obj) {
        if array_contains(touched_objs, _touched_obj) return false
        array_push(touched_objs, _touched_obj)
        return !array_contains(prev_touched_objs, _touched_obj)
    }
    
    static prepare = function() {
        if frame_last_used == global.hb_frame return // Already used this frame
        var frame_since_last_used = global.hb_frame - frame_last_used
        frame_last_used = global.hb_frame
        
        if frame_since_last_used > 1
            array_clear(prev_touched_objs)
        else
            array_copy_simple(prev_touched_objs, touched_objs)
        array_clear(touched_objs)
    }
}

function ContinuousHitTracker() : HitTracker() constructor {
    frame_last_used = 0
    
    static register = function(_touched_obj) {
        if array_contains(touched_objs, _touched_obj) return false
        array_push(touched_objs, _touched_obj)
        return true
    }
    
    static prepare = function() {
        if frame_last_used == global.hb_frame return // Already used this frame
        frame_last_used = global.hb_frame
        
        array_clear(touched_objs)
    }
    
}