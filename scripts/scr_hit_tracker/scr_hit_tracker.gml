/// @desc Struct used by hitboxes to keep track of what they're touching. A set of hitboxes sharing a tracker won't hit an object at the same time - good for e.g. attacks with sweet spots.
/// @param {Bool} _is_continuous Whether an object can be hit continuously (i.e. once every frame).
function HitTracker(_is_continuous = false) constructor {
    touched_objs = []
    prev_touched_objs = []
    frame_last_used = 0
    is_continuous = _is_continuous
    
    /// @desc Registers an object as having been touched this frame, and returns whether it should be considered a new hit.
    /// @param {Any} _touched_obj The object to attempt to register.
    /// @return {Bool} Whether the object was considered "hit".
    static register = function(_touched_obj) {
        _prepare()
        if array_contains(touched_objs, _touched_obj) return false
        array_push(touched_objs, _touched_obj)
        if is_continuous return true
        return !array_contains(prev_touched_objs, _touched_obj)
    }
    
    static _prepare = function() {
        if frame_last_used == global.hb_frame return // Already used this frame
        var frame_since_last_used = global.hb_frame - frame_last_used
        frame_last_used = global.hb_frame
        
        if is_continuous || frame_since_last_used > 1
            array_clear(prev_touched_objs)
        else
            array_copy_simple(prev_touched_objs, touched_objs)
        array_clear(touched_objs)
    }
}
