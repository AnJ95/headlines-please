extends Control

onready var animation_player = $AnimationPlayer
var is_removing = false


func remove():
    animation_player.play_backwards("in")
    is_removing = true

func on_animation_finished(anim_name):
    if is_removing:
        queue_free()
