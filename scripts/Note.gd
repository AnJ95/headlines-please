extends "res://scripts/Information.gd"

const PADDING = 5
const BORDER = 2

var timeYet = 0

var hasSetSize = false

export var width = 120

onready var NoteArea = get_node("/root/Main/NoteArea")
onready var Clipper = get_node("animation_root")
onready var Label = get_node("animation_root/Label")
onready var Border = get_node("animation_root/Border")

func _ready():
    pass
    reset()
    add_to_group("note")
    Label.rect_size = Vector2(width, 1000)
    Label.set_text(message.text)

func _enter_tree():
    move_to_top()

func reset():
    shuffle_position()

func minimum_size_changed():
    print("changed")

func _process(delta):
    if not hasSetSize:
        timeYet += delta 
        if timeYet > 0.1:
            hasSetSize = true
            
            var size = Vector2(width, Label.get_combined_minimum_size().y)
            
            rect_size = size + Vector2(2*PADDING + 2*BORDER, 2*PADDING + 2*BORDER)
            Clipper.rect_size = rect_size
            
            Border.rect_position = Vector2(0, 0)
            Border.rect_size = size + Vector2(2*PADDING + 2*BORDER, 2*PADDING + 2*BORDER)
            
            #get_node("Background").rect_position = Vector2(BORDER, BORDER)
            #get_node("Background").rect_size = size + Vector2(2*PADDING, 2*PADDING)
            
            Label.rect_position = Vector2(BORDER + PADDING, BORDER + PADDING)
            Label.rect_size = size     


func shuffle_position():
    var outer = NoteArea.get_global_rect()
    var inner = get_global_rect()

    var maxW = outer.size.x - inner.size.x
    var maxH = outer.size.y - inner.size.y

    rect_position = Vector2(outer.position.x + randf() * maxW, outer.position.y + randf() * maxH)
    return true