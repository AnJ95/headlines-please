extends "res://scripts/Droppable.gd"

var minY
var maxY
const scrollHeight = 200
const tween_speed = 100
var isVacuuming = false

# used for animating left&right on day_end
onready var animation_player = get_node("AnimationPlayer")
# used for animating up&down on drag
onready var tween = get_node("Tween")
# used for shaking the sprite
onready var shake_animation_player = get_node("Sprite/AnimationPlayer")
onready var audio_stream_player = get_node("AudioStreamPlayer")
onready var audio_stream_player_node = get_node("AudioStreamPlayerNode")
onready var audio_stream_player_grab = get_node("AudioStreamPlayerGrab")

func _ready():
    minY = rect_position.y
    maxY = minY + scrollHeight

# from Droppable
func accepted_groups():
    return ["dropzone", "note", "phax"]

# from Droppable
func accepts_drops_now():
    return isVacuuming

# from Droppable
func on_enter(draggable):
    audio_stream_player_node.play()
    draggable.get_parent().remove_child(draggable)
    stop_shaking()

# from Droppable
func hovering_now(draggable):
    start_shaking()
    pass

# from Droppable
func not_hovering():
    stop_shaking()
    pass
    
# from Draggable
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
   
# from Draggable
func start_drag():
    if !audio_stream_player.playing:
        audio_stream_player.play()
    audio_stream_player_grab.play()
    pass

# from Draggable
func stop_drag():
    if rect_position.y - minY > scrollHeight / 2:
        move_in()
    else:
        move_out()
    audio_stream_player_grab.stop()

func move_in():
    var start = rect_position.y
    tween.interpolate_property(self, "margin_top", start, maxY, (maxY - start) / tween_speed, Tween.TRANS_BOUNCE, Tween.EASE_OUT)
    tween.start()
    isVacuuming = true
    
func move_out():
    var start = rect_position.y
    tween.interpolate_property(self, "margin_top", start, minY, (start - minY) / tween_speed, Tween.TRANS_BOUNCE, Tween.EASE_OUT)
    tween.start()
    isVacuuming = false
    audio_stream_player.stop()
    
    
func start_shaking():
    if !shake_animation_player.is_playing():
        shake_animation_player.play("shake")
        
func stop_shaking():
    if shake_animation_player.is_playing():
        shake_animation_player.stop()
    