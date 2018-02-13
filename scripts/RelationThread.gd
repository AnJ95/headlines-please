extends Control

onready var colorRect = $ColorRect
onready var tween = $Tween
const ANIMATION_TIME = 0.5
var last_color = null
var height


func _ready():
    height = rect_size.y

func init(relation, elem_a, elem_b):
    set_positions(elem_a.rect_position + elem_a.rect_size / 2, elem_b.rect_position + elem_b.rect_size / 2)
    set_color(relation)

func update(relation):
    set_color(relation)

func set_positions(a, b):
    rect_position = a + Vector2(height / 2, height / 2)
    rect_size = Vector2(a.distance_to(b) + height, rect_size.y)
    rect_rotation = 180 + 180 * a.angle_to_point(b) / PI

func get_color_by_relation(relation):
    var color = Color(1, 1, 1, 1)   
    if relation > 0:
        color = Color(1 - relation, 1, 1 - relation, 1)
    elif relation < 0:
        color = Color(1, 1 + relation, 1 + relation, 1)
    return color

func set_color(relation):
    var new_color = get_color_by_relation(relation)

    if last_color == null:
        modulate = new_color
    else:
        tween.interpolate_property(self, "modulate", modulate, new_color, ANIMATION_TIME, Tween.TRANS_QUART, Tween.EASE_IN_OUT)
        tween.start()
        
    last_color = new_color