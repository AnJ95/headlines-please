extends "res://scripts/Droppable.gd"

var isVacuuming = false

# used for animating left&right on day_end
onready var animation_player = get_node("AnimationPlayer")

# used for shaking the sprite
onready var shake_animation_player = get_node("Sprite/AnimationPlayer")
onready var audio_stream_player = get_node("AudioStreamPlayer")
onready var audio_stream_player_node = get_node("AudioStreamPlayerNode")
onready var audio_stream_player_grab = get_node("AudioStreamPlayerGrab")

onready var twoState = get_node("TwoStateDraggable")


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
func can_drag_now():
    return not twoState.is_animating()

# from Draggable
func move_drag():
    if twoState.while_moving():
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
    if twoState.after_moving():
        isVacuuming = true
    else:
        isVacuuming = false
        audio_stream_player.stop()

    audio_stream_player_grab.stop()
    
func start_shaking():
    if !shake_animation_player.is_playing():
        shake_animation_player.play("shake")
        
func stop_shaking():
    if shake_animation_player.is_playing():
        shake_animation_player.stop()
        
func clear_children():
    contained_draggables = []
    