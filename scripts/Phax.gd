extends "res://scripts/Draggable.gd"

const PADDING = 5
const BORDER = 2
const ROLL_OUT_TIME = 3

var timeYet = 0
var hasSetSize = false

var moved_distance = 0
var start_y = 0
var rolling_out = true

export var width = 80
var message

onready var InfoArea = get_node("/root/Main/InfoArea")
onready var Clipper = get_node("animation_root")
onready var Label = get_node("animation_root/Label")
onready var Border = get_node("animation_root/Border")



func _ready():
    add_to_group("phax")
    reset()
    start_y = rect_position.y
    rect_position.y += rect_size.y # to counter ScrollMessageManagers behavior
    Label.rect_size = Vector2(width, 1000)
    Label.set_text(message.text)

func init(message):
    self.message = message

func reset():
    pass
    
# from Draggable
func can_drag_now():
    return !rolling_out
  
func _process(delta):
    if hasSetSize:
        if moved_distance < rect_size.y:
            moved_distance += (rect_size.y / ROLL_OUT_TIME) * delta
            rect_position.y = start_y - moved_distance
        else:
            rolling_out = false
        
    
    if not hasSetSize:
        timeYet += delta 
        if timeYet > 0.1:
            hasSetSize = true
            
            var size = Vector2(width, Label.get_combined_minimum_size().y)
            
            rect_size = size + Vector2(2*PADDING + 2*BORDER, 2*PADDING + 2*BORDER)
            Clipper.rect_size = rect_size
            
            Border.rect_position = Vector2(0, 0)
            Border.rect_size = size + Vector2(2*PADDING + 2*BORDER, 2*PADDING + 2*BORDER)
             
            Label.rect_position = Vector2(BORDER + PADDING, BORDER + PADDING)
            Label.rect_size = size

