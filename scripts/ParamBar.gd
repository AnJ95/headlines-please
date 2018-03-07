extends Control

const width = 48

const Arrow = preload("res://scenes/Arrow.tscn")

onready var tween = $Tween

onready var bar_less = $bar_less
onready var bar_more = $bar_more
onready var bar = $bar

onready var lbl_left = $lbl_left
onready var lbl_right = $lbl_right

export var color_left = Color("#5B269D")
export var color_right = Color("#1D7DA6")

var arrow_right_position = Vector2(48, 6)
var arrow_left_position = Vector2(0, 6)

var current_arrow = null
var last_value = null
var has_updated = false

# Position and Size of all three bars
var bar_pos = width / 2
var bar_size = 0
var more_pos = width / 2
var more_size = 0
var more_visible = false
var less_pos = width / 2
var less_size = 0
var less_visible = false


func _ready():
    bar_less.visible = false
    bar_more.visible = false

func init(param):
    lbl_left.set_text(param.name_left)
    lbl_right.set_text(param.name_right)
    pass

# value must be between -1 and 1
func update(value):
    # First hide previous arrow if exists
    if current_arrow != null:
        current_arrow.vanish()
        current_arrow = null
    
    # On first iteration set last value to current
    if last_value == null:
        last_value = value
    
    # Set colors for bars
    bar.color = get_rgba(last_value)
    bar_more.color = get_rgba(value)
    bar_less.color = bar.color
    bar_less.color.a *= 0.5

    # calculate some widths
    var width = scale_value(last_value)
    var change_width = scale_value(last_value - value) 
    var middle = project_value(0)
    
    # position the main bar
    less_visible = true
    more_visible = true
    bar_size = abs(width)
    if last_value < 0: # if left side
        bar_pos = project_value(last_value)
    else: # if right side
        bar_pos = middle
    
    more_size = abs(change_width)
    less_size = more_size
    
    if value >= 0:
        if value >= last_value:
            more_visible = true
            more_pos = bar_pos + bar_size
        if value < last_value and value >= 0:
            less_visible = true
            less_pos = bar_pos + bar_size - less_size
            bar_size -= less_size
    elif value < 0:
        if value < last_value:
            more_visible = true
            more_pos = bar_pos - more_size
        if value >= last_value:
            less_visible = true
            less_pos = bar_pos
            bar_pos += less_size
            bar_size -= less_size
    
    var t = 0.5
    var e = Tween.TRANS_QUART
    var d = Tween.EASE_IN_OUT
    var less_a = 0
    if less_visible:
        less_a = 1
    var more_a = 0
    if more_visible:
        more_a = 1
    tween.interpolate_property(bar, "rect_position", bar.rect_position, Vector2(bar_pos, bar.rect_position.y), t, e, d)
    tween.interpolate_property(bar, "rect_size", bar.rect_size, Vector2(bar_size, bar.rect_size.y), t, e, d)
    tween.interpolate_property(bar_less, "rect_position", bar_less.rect_position, Vector2(less_pos, bar_less.rect_position.y), t, e, d)
    tween.interpolate_property(bar_less, "rect_size", bar_less.rect_size, Vector2(less_size, bar_less.rect_size.y), t, e, d)
    tween.interpolate_property(bar_less, "modulate", bar_less.modulate, Color(1, 1, 1, less_a), t, e, d)
    tween.interpolate_property(bar_more, "rect_position", bar_more.rect_position, Vector2(more_pos, bar_more.rect_position.y), t, e, d)
    tween.interpolate_property(bar_more, "rect_size", bar_more.rect_size, Vector2(more_size, bar_more.rect_size.y), t, e, d)
    tween.interpolate_property(bar_more, "modulate", bar_more.modulate, Color(1, 1, 1, more_a), t, e, d)
    tween.start()
    
    # Show arrow
    if value != last_value:
        current_arrow = Arrow.instance().init("up")
        var color
        
        if value > last_value:
            current_arrow.rect_position = arrow_right_position
            color = color_right
        elif value < last_value:
            current_arrow.rect_position = arrow_left_position
            color = color_left
        
        add_child(current_arrow)
        color.a = abs(last_value - value) * 0.3 + 0.3
        if color.a > 1:
            color.a = 1
        current_arrow.set_color(color)
    
    last_value = value

func scale_value(value):
    return round(value * width / 2)

func project_value(value):
    return round((value + 1) * width / 2)
    
    
func get_rgb(value):
    var rgb
    if value >= 0:
        rgb = color_right
    else:
        rgb = color_left
    return Color(rgb.r, rgb.g, rgb.b, 1)
    
func get_rgba(value):
    var rgb = get_rgb(value)
    return Color(rgb.r, rgb.g, rgb.b, 0.1 + abs(value * 0.9))

    