extends Control

var max_width
var height
onready var tween = $Tween
onready var progress = $progress

func _ready():
    max_width = progress.rect_size.x
    height = progress.rect_size.y

# Like update but without animation for init
func set(new_value):
    progress.rect_size.x = new_value * max_width
    
func update(new_value):
    var start = progress.rect_size
    var end = Vector2(new_value * max_width, height)
    tween.interpolate_property(progress, "rect_size", start, end, 0.5, Tween.TRANS_QUAD, Tween.EASE_IN_OUT)
    tween.start()