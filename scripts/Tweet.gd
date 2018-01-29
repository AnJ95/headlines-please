extends "res://scripts/Draggable.gd"

export var PADDING = 2
export var BORDER = 2
export var WIDTH = 132
export var HEIGHT = 44

var timeYet = 0

var hasSetSize = false

var message

onready var label = get_node("Label")
onready var bg = get_node("Background")
onready var border = get_node("Border")

var is_selected

var static_copy

var selectedDropZone = null

func _ready():
    add_to_group("tweet")
    label.rect_size = Vector2(WIDTH, HEIGHT)
    label.set_text(message.text)

func init(message):
    self.message = message
  

func _process(delta):
    return
    
    if not hasSetSize:
        timeYet += delta 
        if timeYet > 0.1:
            hasSetSize = true
            var size = Vector2(WIDTH, label.get_combined_minimum_size().y)
            rect_size = size + Vector2(2*PADDING, 2*PADDING + + 2*BORDER)
            
            border.rect_position = Vector2(0, 0)
            border.rect_size = size + Vector2(2*PADDING, 2*PADDING + 2*BORDER)

            bg.rect_position = Vector2(0, BORDER)
            bg.rect_size = size + Vector2(2*PADDING, 2*PADDING)

            label.rect_position = Vector2(PADDING, PADDING + BORDER)
            label.rect_size = size

func move_drag():
    pass

func start_drag():
    if is_in_feed():
        #create a not draggable copy and be moved
        static_copy = duplicate()
        static_copy.mouse_filter = MOUSE_FILTER_IGNORE
        static_copy.init(message)
        get_parent().add_child(static_copy)


func stop_drag():
                    
    if is_in_feed():
        selectedDropZone = null
        #rect_position = static_copy.rect_position
        static_copy.queue_free()
    else:
        queue_free()


func add_to_dropzone(dropZone):
    if is_in_feed():
        #add copy to dropzone and make draggable
        #original back to feed
        
        var tmp_pos = static_copy.rect_position
        get_parent().remove_child(static_copy)
        dropZone.add_child(static_copy)
        static_copy.rect_position = get_global_rect().position - dropZone.get_global_rect().position
        rect_position = tmp_pos
        static_copy.selectedDropZone = dropZone
        static_copy.mouse_filter = MOUSE_FILTER_STOP
        
        static_copy = null
    else:
        rect_position -= dropZone.rect_position - get_parent().rect_position
        dropZone.add_child(static_copy)
        
func reset():
    queue_free()
    
func add_to_draggables():
    pass
    
func is_in_feed():
    return selectedDropZone == null

func _on_Info_mouse_entered():
    isMouseIn = true

func _on_Info_mouse_exited():
    isMouseIn = false
