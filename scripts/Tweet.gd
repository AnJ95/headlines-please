extends "res://scripts/Information.gd"

var static_copy
var is_in_feed = true

func _ready():
    pass
    add_to_group("tweet")

# from Draggable
func on_drop(droppable):
    if is_in_feed:
        static_copy.queue_free()
    is_in_feed = false
    
# from Draggable
func on_drop_in_root():
    queue_free()
    if is_in_feed:
        static_copy.mouse_filter = MOUSE_FILTER_STOP


# from Draggable
func start_drag():
    if is_in_feed:
        #create a not draggable copy and be moved
        static_copy = duplicate()
        static_copy.mouse_filter = MOUSE_FILTER_IGNORE
        static_copy.init(message)
        get_parent().add_child(static_copy)
    
