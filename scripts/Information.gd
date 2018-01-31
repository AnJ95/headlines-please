extends "res://scripts/Draggable.gd"

export var width = 120
export var padding = 5

const FLY_OUT_SPEED = 300

onready var Clipper = get_node("animation_root")
onready var Label = get_node("animation_root/Label")
onready var Background = get_node("animation_root/Background")
onready var tween = get_node("Tween")

var initialized_size = false
var message

func _ready():
    pass
    Label.rect_size = Vector2(width, 1000)
    Label.set_text(message.text)
    add_to_group("information")
    get_tree().get_root().get_node("/root/Main").connect("day_ended", self, "on_day_ended", ["world"])
    tween.connect("tween_completed", self, "on_tween_completed", ["object", "key"])

func init(message):
    self.message = message
    
func reset():
    pass

func on_day_ended(node, world):
    if containing_droppable == null:
        #queue_free()
        var start = get_global_rect().position + rect_size / 2
        var middle = Root.rect_position + Root.rect_size / 2

        var angle = start.angle_to_point(middle)
        
        var distance_from_middle = 800
        var distance_left = distance_from_middle - start.distance_to(middle)
        
        var target = start + Vector2(distance_left, 0).rotated(angle)
        
        tween.interpolate_property(self, "rect_position", rect_position, target - rect_size / 2, distance_left / FLY_OUT_SPEED, Tween.TRANS_CUBIC, Tween.EASE_OUT)
        tween.start()
        
func on_tween_completed(object, key):
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