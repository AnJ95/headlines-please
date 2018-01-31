extends "res://scripts/Draggable.gd"

onready var twoState = get_node("TwoStateDraggable")

# from Draggable
func move_drag():
    twoState.while_moving()

# from Draggable
func stop_drag():
    twoState.after_moving()

# from Draggable
func can_drag_now():
    return not twoState.is_animating()
    
func update(countries):
    for country in countries:
        get_node("Country" + country.name).update(country)
    pass
