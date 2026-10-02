/// @desc Deletes every value from an array.
function array_clear(_array) {
    var length = array_length(_array)
    if length > 0
        array_delete(_array, 0, length)
}

/// @desc Makes the destination array a copy of the source array.
function array_copy_simple(_dest, _src) {
    var src_length = array_length(_src)
    array_copy(_dest, 0, _src, 0, src_length)
    var length_diff = src_length - array_length(_dest)
    if length_diff < 0
        array_delete(_dest, -1, length_diff)
}