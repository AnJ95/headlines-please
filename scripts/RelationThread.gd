extends Control
var height
onready var colorRect = $ColorRect

func _ready():
    height = rect_size.y

func init(relation, elem_a, elem_b):
    set_positions(elem_a.rect_position + elem_a.rect_size / 2, elem_b.rect_position + elem_b.rect_size / 2)
    set_color(relation)

func set_positions(a, b):
    rect_position = a + Vector2(height / 2, height / 2)
    rect_size = Vector2(a.distance_to(b) + height, rect_size.y)
    rect_rotation = 180 + 180 * a.angle_to_point(b) / PI
    
func set_color(relation):
    pass