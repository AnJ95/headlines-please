extends "res://scripts/ScrollInformation.gd"

var is_folding = false
const UNFOLD_TIME = 0.4

func _ready():
    pass
    add_to_group("phax")
    reset()
    rect_position.y += rect_size.y # to counter ScrollMessageManagers behavior

# from Draggable
func start_drag():
    manager.remove(self)
    if is_folding:
        tween.interpolate_property(self, "rect_scale", rect_scale, Vector2(1, 1), UNFOLD_TIME, Tween.TRANS_QUAD, Tween.EASE_IN_OUT)
        tween.start()
    
func adjust_position(current_shift, max_shift):
    is_folding = true
    var progress = current_shift / max_shift
    rect_scale.y = 1 - progress
    rect_position.y = cached_y - current_shift + get_maximum_height() * progress
