extends "res://scripts/Information.gd"

export var roll_out_time = 3

var moved_distance = 0
var start_y = 0
var rolling_out = false
var manager
var cached_y

func _ready():
    pass
     # make invisible but still be rendered
    self.modulate.a = 0
    start_y = rect_position.y
    
# from Draggable
func can_drag_now():
    return !rolling_out

# Could not use pass to get Informations standard behavior for some reason
func on_size_change():
    # true if initial, false otherwise
    if adjust_size():
        self.modulate.a = 1
        rolling_out = true
        
# set the ScrollInformationManager
func set_manager(manager):
    self.manager = manager

# get the current height of the animation or the height if the animation is done 
func get_current_height():
    return moved_distance

# save the current y position
func cache_y():
    cached_y = rect_position.y

# get the cached y position
func get_cached_y():
    return cached_y

# Called when another ScrollInformation is entering
# Overwrite this
func on_next_information():
    pass

func _process(delta):
    if rolling_out:
        if moved_distance < rect_size.y + manager.information_padding:
            moved_distance += (rect_size.y / roll_out_time) * delta
            rect_position.y = start_y - moved_distance# + sin(moved_distance / 2) * 2
            Clipper.rect_size.y = moved_distance
        else:
            manager.done_rolling()
            rolling_out = false

