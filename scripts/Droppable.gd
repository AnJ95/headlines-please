extends "res://scripts/Draggable.gd"

var hovering_time = 0
var hovering_element = null
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
func on_enter(draggable):
    pass
    
# overwrite this
func on_leave(draggable):
    pass
    
func internal_on_enter(draggable):
    contained_draggables.append(draggable)
    on_enter(draggable)
    
func internal_on_leave(draggable):
    contained_draggables.erase(draggable)
    on_leave(draggable)

# called multiple times  
func hovering_now(draggable):
    hovering_element = draggable
    pass

func not_hovering():
    hovering_element = null
    hovering_time = 0
    pass

func _process(delta):
    hovering_time += delta
    if hovering_element != null and hovering_time > MOVE_TO_TOP_TIME:
        move_to_top()
        hovering_element.move_to_top()