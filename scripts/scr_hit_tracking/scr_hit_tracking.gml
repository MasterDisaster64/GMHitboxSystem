global.hb_touches_this_frame = ds_map_create()
global.hb_touches_last_frame = ds_map_create()

function hit_register(_a, _b, _continuous) {
    try {
        var a_touches = global.hb_touches_this_frame[? _a]
        if array_contains(a_touches, _b) return false
        array_push(a_touches, _b)
    }
    catch (e) {
        global.hb_touches_this_frame[? _a] = [_b]
    }
    
    if _continuous return true
    
    try {
        return !array_contains(global.hb_touches_last_frame[? _a], _b)
    }
    catch (e) {
        return true
    }
}

var step = function() {
    ds_map_copy(global.hb_touches_last_frame, global.hb_touches_this_frame)
    ds_map_clear(global.hb_touches_this_frame)
}
var cycle = time_source_create(time_source_game, 1, time_source_units_frames, step, [], -1)
time_source_start(cycle)

