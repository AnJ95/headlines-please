extends Control

const underline_pad = 4
const underline_height = 4

onready var label = get_node("Label")
onready var button = get_node("TextureButton")
onready var underline = get_node("headline_underline")
var size_adjusted = false
var dropzone = null
var is_clickable = false
var model

func init(var headline, var clickElem, var clickMethod):
    model = headline
    label.text = headline.text
    if clickElem != null:
        is_clickable = true
        button.connect("pressed", clickElem, clickMethod, [headline])

func on_size_changed():
    if size_adjusted:
        return
    var h = label.get_minimum_size().y
    
    label.rect_size.y = h
    button.rect_size.y = h + underline_pad + underline_height
    self.rect_size.y = h + underline_pad + underline_height
    underline.position.y = h + underline_pad
    
    size_adjusted = true
    if dropzone != null:
        dropzone.notify_size_adjusted()

func register_dropzone(dropzone):
    self.dropzone = dropzone

func on_mouse_entered():
    if is_clickable:
        rect_position.y += 1


func on_mouse_exited():
    if is_clickable:
        rect_position.y -= 1