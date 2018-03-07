extends Control

const Arrow = preload("res://scenes/Arrow.tscn")
export var arrow_position = Vector2(125, 5)

onready var tween = $Tween
onready var progress = $progress

var current_value
var max_width
var height
var current_arrow = null

func _ready():
    max_width = progress.rect_size.x
    height = progress.rect_size.y
    
func value_increase(value):
    value_changed(value, Arrow.instance().init("up"), get_color(1))
    
func value_decrease(value):
    value_changed(value, Arrow.instance().init("down"), get_color(0))
    
func value_changed(value, arrow, color):
    current_arrow = arrow
    
    animate_to(value)
    
    # add arrow indicator
    arrow.rect_position = arrow_position
    add_child(arrow)
    arrow.set_color(color)

func animate_to(value):
    tween.interpolate_property(progress, "rect_size", progress.rect_size, get_size(value), 1.5, Tween.TRANS_QUART, Tween.EASE_IN_OUT)
    tween.interpolate_property(progress, "color", progress.color, get_color(value), 1.5, Tween.TRANS_QUART, Tween.EASE_IN_OUT)
    tween.start()
    
func set_to(value):
    progress.rect_size = get_size(value)
    progress.color = get_color(value)
    
func update(new_value):
    # First hide previous arrow if exists
    if current_arrow != null:
        current_arrow.vanish()
        current_arrow = null
        
    # Then check if value actually changed
    if current_value != null:
        if new_value > current_value:
            value_increase(new_value)
        elif new_value < current_value:
            value_decrease(new_value)
    else:
        set_to(new_value)
    current_value = new_value
    

func get_size(progress):
    return Vector2(progress * max_width, height)

func get_color(progress):
    if progress < 0:
        return get_color(0)
    if progress > 1:
        return get_color(1)
    
    var y = sin(progress * PI)
    return Color(1 - (y * y), y * y, 0, 1)