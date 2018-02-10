extends Control

var is_down
var is_vanishing = false

onready var animationPlayer = $AnimationPlayer
onready var spriteUp = $animation_root/up
onready var spriteDown = $animation_root/down

func init(dir):
    is_down = (dir == "down")
    return self
    
func _ready():
    appear()
    spriteUp.visible = !is_down
    spriteDown.visible = is_down

func appear():
    if is_down:
        animationPlayer.play("down")
    else:
        animationPlayer.play("up")
        
func vanish():
    animationPlayer.play("vanish")
    is_vanishing = true      

func on_animation_finished(anim_name):
    if is_vanishing:
        queue_free()
