extends "res://scripts/Information.gd"

export var roll_out_time = 3

var moved_distance = 0
var start_y = 0
var rolling_out = false
var manager
var cached_y

func _ready():
    pass
    start_y = rect_position.y

func on_day_ended(node, world):
    .on_day_ended(node, world)
    rolling_out = false
    pass
        
# from Draggable
func can_drag_now():
    return !rolling_out

# Could not use pass to get Informations standard behavior for some reason
func on_size_change():
    # true if initial, false otherwise
    if adjust_size():
        rolling_out = true
        
# set the ScrollInformationManager
func set_manager(manager):
    self.manager = manager

# get the current height of the animation
func get_current_height():
    return moved_distance
    
# get the maximal height this element wil have after the animation
func get_maximum_height():
    return rect_size.y + manager.information_padding

# Called when another ScrollInformation is entering
func on_next_information():
    cached_y = rect_position.y
    
# Called when another ScrollInformation is pushin this one upwards
func adjust_position(current_shift, max_shift):
    rect_position.y = cached_y - current_shift

func _process(delta):
    if rolling_out:
        if moved_distance < get_maximum_height():
            moved_distance += (rect_size.y / roll_out_time) * delta
            rect_position.y = start_y - moved_distance# + sin(moved_distance / 2) * 2
            Clipper.rect_size.y = moved_distance
        else:
            manager.done_rolling()
            rolling_out = false

