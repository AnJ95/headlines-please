extends "res://scripts/Draggable.gd"

const PADDING = 5
const BORDER = 2

var timeYet = 0

var hasSetSize = false

export var width = 120
var message

onready var outer = get_node("/root/Main/InfoArea")

func _ready():
    add_to_group("info")
    reset()
    get_node("Label").rect_size = Vector2(width, 1000)
    get_node("Label").set_text(message.text)

func init(message):
    self.message = message
    
func reset():
    shuffle_position()

func _process(delta):
    
    if not hasSetSize:
        timeYet += delta 
        if timeYet > 0.1:
            hasSetSize = true
            
            var size = Vector2(width, get_node("Label").get_combined_minimum_size().y)
            
            rect_size = size + Vector2(2*PADDING + 2*BORDER, 2*PADDING + 2*BORDER)
            
            get_node("Border").rect_position = Vector2(0, 0)
            get_node("Border").rect_size = size + Vector2(2*PADDING + 2*BORDER, 2*PADDING + 2*BORDER)
            
            #get_node("Background").rect_position = Vector2(BORDER, BORDER)
            #get_node("Background").rect_size = size + Vector2(2*PADDING, 2*PADDING)
            
            get_node("Label").rect_position = Vector2(BORDER + PADDING, BORDER + PADDING)
            get_node("Label").rect_size = size
            
    pass


func shuffle_position():
    var outer = get_node("/root/Main/InfoArea").get_global_rect()
    var inner = get_global_rect()

    var maxW = outer.size.x - inner.size.x
    var maxH = outer.size.y - inner.size.y

    rect_position = Vector2(randf() * maxW, randf() * maxH)


func can_be_vacuumed():
    return true