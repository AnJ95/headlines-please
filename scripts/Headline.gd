extends Control

const underline_pad = 4
const underline_height = 4

onready var label = $Label
onready var button = $TextureButton
onready var underline = $headline_underline
onready var tween = $Tween

var is_disappearing = false
var size_adjusted = false
var dropzone = null
var is_clickable = false
var model
var has_initiated_y = false

func _ready():
    modulate = Color(1,1,1,0)

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

func appear():
    tween.interpolate_property(self, "modulate", Color(1,1,1,0), Color(1,1,1,1), 0.3, Tween.TRANS_QUAD, Tween.EASE_IN_OUT)
    tween.start()
    
func disappear():
    is_disappearing = true
    tween.interpolate_property(self, "modulate", Color(1,1,1,1), Color(1,1,1,0), 0.3, Tween.TRANS_QUAD, Tween.EASE_IN_OUT)
    tween.start()
    
func move_to(y):
    var end = Vector2(rect_position.x, y)
    if has_initiated_y:
        tween.interpolate_property(self, "rect_position", rect_position, end, 0.3, Tween.TRANS_QUAD, Tween.EASE_IN_OUT)
        tween.start()
    else:
        rect_position = Vector2(rect_position.x, y)
    has_initiated_y = true

func tween_completed(object, key):
    if is_disappearing:
        queue_free()
        get_parent().remove_child(self)
        dropzone.adjust_headline_positions()
