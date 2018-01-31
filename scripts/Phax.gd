extends "res://scripts/Information.gd"

const ROLL_OUT_TIME = 3

var moved_distance = 0
var start_y = 0
var rolling_out = false

func _ready():
    pass
    add_to_group("phax")
    reset()
    start_y = rect_position.y
    rect_position.y += rect_size.y # to counter ScrollMessageManagers behavior
    
# from Draggable
func can_drag_now():
    return !rolling_out

# Could not use pass to get Informations standard behavior for some reason
func on_size_change_no_overwrite():
    on_size_change()
    rolling_out = true
    
func _process(delta):
    if rolling_out:
        if moved_distance < rect_size.y:
            moved_distance += (rect_size.y / ROLL_OUT_TIME) * delta
            rect_position.y = start_y - moved_distance + sin(moved_distance / 2) * 2
        else:
            rolling_out = false

