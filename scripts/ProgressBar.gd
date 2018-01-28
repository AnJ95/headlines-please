extends ColorRect

var max_width
func _ready():
    max_width = rect_size.x

func update(progress):
    rect_size.x = progress * max_width