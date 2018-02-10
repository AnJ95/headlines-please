extends Control

var max_width
var height
onready var tween = $Tween
onready var progress = $progress

func _ready():
    max_width = progress.rect_size.x
    height = progress.rect_size.y

func update(new_value):
    var start = progress.rect_size
    var end = Vector2(new_value * max_width, height)
    tween.interpolate_property(progress, "rect_size", start, end, 1.5, Tween.TRANS_QUART, Tween.EASE_IN_OUT)
    start = progress.color
    end = get_color(new_value)
    tween.interpolate_property(progress, "color", start, end, 1.5, Tween.TRANS_QUART, Tween.EASE_IN_OUT)
    tween.start()

func get_color(progress):
    if progress < 0:
        return get_color(0)
    if progress > 1:
        return get_color(1)
    
    var y = sin(progress * PI)
    return Color(1 - y, y * y, 0, 1)