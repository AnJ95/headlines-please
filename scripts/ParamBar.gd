extends Control



onready var handle = $handle
onready var last = $last
onready var bar = $bar

onready var lbl_left = $lbl_left
onready var lbl_right = $lbl_right

export var color_left = Color("#5B269D")
export var color_right = Color("#1D7DA6")

const width = 48
var has_updated = false

func _ready():
    last.visible = false

func init(param):
    lbl_left.set_text(param.name_left)
    lbl_right.set_text(param.name_right)
    pass

func update(value):
    print(value)
    if has_updated:
        # save the indicator to current position
        last.rect_position.x = handle.rect_position.x
        last.visible = true
    has_updated = true
    
    handle.color = get_rgb(value)
    bar.color = get_rgba(value)
    last.color = get_rgb(value)
    last.color.a = 0.7
    
    bar.rect_size.x = round(abs(value) * width / 2 - 1)
    handle.rect_position.x = bar.rect_position.x
    
    
    if value < 0: # if left side
        bar.rect_position.x = round(width / 2 - bar.rect_size.x)
        handle.rect_position.x -= 2
        
    else: # if right side
        bar.rect_position.x = round(width / 2)
        handle.rect_position.x += bar.rect_size.x
    pass
    
    
    
    
func get_rgb(value):
    var rgb
    if value >= 0:
        rgb = color_right
    else:
        rgb = color_left
    return Color(rgb.r, rgb.g, rgb.b, 1)
    
func get_rgba(value):
    var rgb = get_rgb(value)
    return Color(rgb.r, rgb.g, rgb.b, abs(value))

    