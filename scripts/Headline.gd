extends Control

onready var Label = get_node("TextureButton/Label")
onready var Button = get_node("TextureButton")

func init(var headline, var vecPos, var clickElem, var clickMethod):
    rect_position = vecPos
    Label.text = headline.text
    if clickElem != null:
        Button.connect("pressed", clickElem, clickMethod, [headline])

