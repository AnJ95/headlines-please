extends "res://scripts/Draggable.gd"

export var width = 120
export var padding = 5

onready var Clipper = get_node("animation_root")
onready var Label = get_node("animation_root/Label")
onready var Background = get_node("animation_root/Background")

var initialized_size = false
var message

func _ready():
    pass
    Label.rect_size = Vector2(width, 1000)
    Label.set_text(message.text)
    add_to_group("information")
    get_tree().get_root().get_node("/root/Main").connect("day_ended", self, "on_day_ended", ["world"])

func init(message):
    self.message = message
    
func reset():
    pass

func on_day_ended(node, world):
    if containing_droppable == null:
        queue_free()
        
func adjust_size():
    if initialized_size:
        return false
    initialized_size = true
    
    var size = Vector2(width, Label.get_combined_minimum_size().y)
            
    rect_size = size + Vector2(2*padding, 2*padding)
    Clipper.rect_size = rect_size
    
    Label.rect_position = Vector2(padding, padding)
    Label.rect_size = size
    return true