extends "res://scripts/Information.gd"

onready var NoteArea = get_node("/root/Main/NoteArea")

onready var audio_stream_player_move = get_node("AudioStreamPlayerMove")
onready var audio_stream_player_flap = get_node("AudioStreamPlayerFlap")

func _ready():
    pass
    reset()
    add_to_group("note")
    move_to_top()
    audio_stream_player_move.play()
    
# from Draggable
func on_drop(droppable):
    audio_stream_player_flap.play()
    
# from Draggable
func on_drop_in_root():
    audio_stream_player_move.play()

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