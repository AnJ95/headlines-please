extends Control

onready var label = get_node("Label")
onready var button = get_node("TextureButton")
onready var underline = get_node("headline_underline")
var size_adjusted = false

func init(var headline, var vecPos, var clickElem, var clickMethod):
    rect_position = vecPos
    label.text = headline.text
    if clickElem != null:
        button.connect("pressed", clickElem, clickMethod, [headline])

func on_size_changed():
    if size_adjusted:
        return
    var h = label.get_minimum_size().y
    size_adjusted = true
    # TODO adjust stuff


func on_mouse_entered():
    rect_position.y += 1


func on_mouse_exited():
    rect_position.y -= 1