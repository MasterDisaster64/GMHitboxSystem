// Simply the number of frames since game start
global.hb_frame = 0

// Increments every frame without an object
var increment = function() {
    global.hb_frame++
}
var frame_counter = time_source_create(time_source_game, 1, time_source_units_frames, increment, [], -1)
time_source_start(frame_counter)