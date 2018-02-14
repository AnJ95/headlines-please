extends Node

export var scrollHeight = 260
export var tween_speed = 200
export(NodePath) var parentPath
export var bounce = false

var minY
var maxY
var parent
var is_animating = false

var ease_trans
var ease_type

onready var tween = get_node("Tween")

func _ready():
    parent = get_node(parentPath)
    minY = parent.rect_position.y
    maxY = minY + scrollHeight
    if bounce:
        ease_trans = Tween.TRANS_BOUNCE
        ease_type = Tween.EASE_OUT
    else:
        ease_trans = Tween.TRANS_QUART
        ease_type = Tween.EASE_IN_OUT

func get_progress():
    return (parent.rect_position.y - minY) / (maxY - minY)

func while_moving():
    parent.rect_position.x = parent.startThisPos.x
    if parent.rect_position.y <= minY:
        parent.rect_position.y = minY
        return false
    if parent.rect_position.y >= maxY:
        parent.rect_position.y = maxY
        return false
    return true
        
func after_moving():
    if parent.rect_position.y - minY > scrollHeight / 2:
        move_in()
        return true
    else:
        move_out()
        return false

func is_animating():
    return is_animating

func move_in():
    var start = parent.rect_position
    tween.interpolate_property(parent, "rect_position", start, Vector2(start.x, maxY), (maxY - start.y) / tween_speed, ease_trans, ease_type)
    tween.start()
    
func move_out():
    var start = parent.rect_position
    tween.interpolate_property(parent, "rect_position", start, Vector2(start.x, minY), (start.y - minY) / tween_speed, ease_trans, ease_type)
    tween.start()

func on_tween_started( object, key ):
    print("start")
    is_animating = true
    
func on_tween_completed( object, key ):
    print("end")
    is_animating = false
