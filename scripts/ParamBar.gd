extends Control

var current_value
var current_arrow = null

export var arrow_position = Vector2(125, 5)
onready var progress_bar = $progress_bar
onready var lbl_left = $lbl_left
onready var lbl_right = $lbl_right

var Arrow = preload("res://scenes/Arrow.tscn")

func init(param):
    lbl_left.set_text(param.name_left)
    lbl_right.set_text(param.name_right)
    pass

func update(value):
    # First hide previous arrow if exists
    if current_arrow != null:
        current_arrow.vanish()
        current_arrow = null
        print ("vanish + " + str(value))
    
    # Then check if value actually changed
    if current_value != null:
        if value > current_value:
            value_increase(value)
        elif value < current_value:
            value_decrease(value)
    else:
        progress_bar.set(value / 2 + 0.5)
    current_value = value
    
func value_increase(value):
    value_changed(value, Arrow.instance().init("up"))
    
func value_decrease(value):
    value_changed(value, Arrow.instance().init("down"))
    
func value_changed(value, arrow):
    current_arrow = arrow
    
    # animate bar movement
    progress_bar.update(value / 2 + 0.5)
    
    # add arrow indicator
    arrow.rect_position = arrow_position
    add_child(arrow)
    
    
    