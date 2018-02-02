extends Control

var max_width

onready var progress = $progress

func _ready():
    max_width = progress.rect_size.x

func update(value):
    progress.rect_size.x = value * max_width