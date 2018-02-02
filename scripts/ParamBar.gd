extends Control

var current_value

onready var progress_bar = $progress_bar
onready var lbl_left = $lbl_left
onready var lbl_right = $lbl_right


func init(param):
    lbl_left.set_text(param.name_left)
    lbl_right.set_text(param.name_right)
    pass

func update(value):
    current_value = value
    progress_bar.update(value / 2 + 0.5)