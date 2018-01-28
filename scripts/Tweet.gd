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

func _ready():
    add_to_group("info")
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
    pass


func stop_drag():
    var dropZone = get_node("/root/Main/DropZone")
    #var infoManager = get_tree().get_current_scene().get_node("InfoArea")

    for dropZone in get_tree().get_nodes_in_group("dropzone"):
        if dropZone.current_state == 0:
            isSelected = get_global_rect().intersects(dropZone.get_global_rect())
            #update_view();
            return #TODO maybe sort by children index first?

func _on_Info_mouse_entered():
    isMouseIn = true

func _on_Info_mouse_exited():
    isMouseIn = false
