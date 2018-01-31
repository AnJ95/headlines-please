extends "res://scripts/ScrollInformation.gd"

var original
var is_copy = false

func _ready():
    pass
    print("TWEET")
    add_to_group("tweet")

# from Draggable
func on_drop(droppable):
    if is_copy and original != null:
        manager.remove(original)
        original.queue_free()
        original = null
        pass
    
    
# from Draggable
func on_drop_in_root():
    if is_copy:
        queue_free()
    pass


# from Draggable
func start_drag():
    if not is_copy:
        var copy = duplicate()
        var target = Root
        
        # prevent dragging
        isDragging = false
        isMouseIn = false
        
        # initialize copy
        copy.init(message)
        copy.rolling_out = false
        copy.initialized_size = true
        copy.is_copy = true
        copy.original = self
        copy.manager = manager
        copy.rect_position = get_global_rect().position
        
        # add copy to absolute root
        target.add_child(copy)
        
        # fake copy to be dragging
        copy.isMouseIn = true
        copy.isDragging = true
        copy.startMousePos = startMousePos
        copy.startThisPos = copy.rect_position
        copy.Background.visible = true
        
    
