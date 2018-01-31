extends "res://scripts/ScrollInformation.gd"

var is_folding = false

func _ready():
    pass
    add_to_group("phax")
    reset()
    rect_position.y += rect_size.y # to counter ScrollMessageManagers behavior

# from Draggable
func start_drag():
    manager.remove(self)
    
func adjust_position(current_shift, max_shift):
    var progress = current_shift / max_shift
    rect_scale.y = 1 - progress
    rect_position.y = cached_y - current_shift + get_maximum_height() * progress
