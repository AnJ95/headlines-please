extends "res://scripts/Draggable.gd"

var hovering_time = 0
var is_hovering = false
var MOVE_TO_TOP_TIME = 1
var contained_draggables = []

func _ready():
    add_to_group("droppable")

# dont overwrite this, use accepts_drops_now()
func can_drop(draggable):
    if not accepts_drops_now():
        return false
    for group in draggable.get_groups():
        if accepted_groups().has(group):
            return true
    return false
    
# overwrite this
func accepts_drops_now():
    return true

# overwrite this
func accepted_groups():
    return []

# overwrite this
func on_drop(draggable):
    pass
    
func internal_on_drop(draggable):
    contained_draggables.append(draggable)
    on_drop(draggable)

# called multiple times  
func hovering_now():
    is_hovering = true
    pass

func not_hovering():
    is_hovering = false
    hovering_time = 0
    pass

func _process(delta):
    hovering_time += delta
    #if is_hovering and hovering_time > MOVE_TO_TOP_TIME:
    #    move_to_top()