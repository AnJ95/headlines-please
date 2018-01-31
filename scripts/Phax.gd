extends "res://scripts/Information.gd"

const PADDING = 5
const ROLL_OUT_TIME = 3

var timeYet = 0
var hasSetSize = false

var moved_distance = 0
var start_y = 0
var rolling_out = true

export var width = 80

func _ready():
    pass
    add_to_group("phax")
    reset()
    start_y = rect_position.y
    rect_position.y += rect_size.y # to counter ScrollMessageManagers behavior
    Label.rect_size = Vector2(width, 1000)
    Label.set_text(message.text)
    
# from Draggable
func can_drag_now():
    return !rolling_out
  
func _process(delta):
    if hasSetSize:
        if moved_distance < rect_size.y:
            moved_distance += (rect_size.y / ROLL_OUT_TIME) * delta
            rect_position.y = start_y - moved_distance + sin(moved_distance / 2) * 2
        else:
            rolling_out = false
        
    
    if not hasSetSize:
        timeYet += delta 
        if timeYet > 0.1:
            hasSetSize = true
            
            var size = Vector2(width, Label.get_combined_minimum_size().y)
            
            rect_size = size + Vector2(2*PADDING, 2*PADDING)
            Clipper.rect_size = rect_size
            
            Label.rect_position = Vector2(PADDING, PADDING)
            Label.rect_size = size

