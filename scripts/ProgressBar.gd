extends Control

var current_value
var max_width

onready var progress = $progress
onready var lbl_left = $lbl_left
onready var lbl_right = $lbl_right

func _ready():
    max_width = progress.rect_size.x

func init(param):
    lbl_left.set_text(param.name_left)
    lbl_right.set_text(param.name_right)
    pass

func update(value):
    current_value = value
    progress.rect_size.x = value * max_width