extends "res://scripts/Information.gd"

onready var NoteArea = get_node("/root/Main/NoteArea")

func _ready():
    pass
    reset()
    add_to_group("note")

func _enter_tree():
    move_to_top()

func shuffle_position():
    var outer = NoteArea.get_global_rect()
    var inner = get_global_rect()

    var maxW = outer.size.x - inner.size.x
    var maxH = outer.size.y - inner.size.y

    rect_position = Vector2(outer.position.x + randf() * maxW, outer.position.y + randf() * maxH)
    return true

func adjust_size():
    .adjust_size()
    shuffle_position()