extends "res://scripts/Draggable.gd"

var minY
const scrollHeight = 200
var maxY
var handIns = []
var isVacuuming = false

onready var audio_stream_player = get_node("AudioStreamPlayer")
onready var audio_stream_player_node = get_node("AudioStreamPlayerNode")
onready var audio_stream_player_grab = get_node("AudioStreamPlayerGrab")

func _ready():
    minY = rect_position.y
    maxY = minY + scrollHeight
    
func move_drag():
    rect_position.x = startThisPos.x
    if rect_position.y < minY:
        rect_position.y = minY
        audio_stream_player_grab.stop()
    elif rect_position.y > maxY:
        rect_position.y = maxY
        audio_stream_player_grab.stop()
    else:
        if !audio_stream_player.playing:
            audio_stream_player.play()
        if !audio_stream_player_grab.playing:
            audio_stream_player_grab.play()
            
    
    
func start_drag():
    if !audio_stream_player.playing:
        audio_stream_player.play()
    audio_stream_player_grab.play()
    pass

func stop_drag():
    if rect_position.y - minY > scrollHeight / 2:
        rect_position.y = maxY # TODO animate
        isVacuuming = true
    else:
        rect_position.y = minY # TODO animate
        isVacuuming = false
        audio_stream_player.stop()
    audio_stream_player_grab.stop()



func handIn(draggable):
    audio_stream_player_node.play()
    handIns.append(draggable)
    
    