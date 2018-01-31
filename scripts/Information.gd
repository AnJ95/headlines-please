extends "res://scripts/Draggable.gd"

var message
onready var Clipper = get_node("animation_root")
onready var Label = get_node("animation_root/Label")

func _ready():
    pass
    add_to_group("information")
    get_tree().get_root().get_node("/root/Main").connect("day_ended", self, "on_day_ended", ["world"])

func init(message):
    self.message = message
    
func reset():
    pass

func on_day_ended(node, world):
    if containing_droppable == null:
        queue_free()