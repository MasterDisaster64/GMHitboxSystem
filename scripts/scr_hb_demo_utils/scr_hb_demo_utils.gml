/// @param {Id.Instance} _instance description
/// @param {Real} _amount description
/// @param {Constant.Color} name description
function do_damage(_instance, _amount, _text_color = c_white) {
    var text_obj = instance_create_depth(_instance.x, _instance.bbox_top, -10, obj_hb_floating_text)
    text_obj.text = _amount
    text_obj.color = _text_color
}