extends Control

export var time_to_vanish = 2

var is_down
var time = 0
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
# Alternative animation
#    if is_down:
#        animationPlayer.play("up")
#    else:
#        animationPlayer.play("down")

func _process(delta):
    if not is_vanishing:
        time += delta
        if time > time_to_vanish:
            is_vanishing = true
            vanish()
        

func on_animation_finished(anim_name):
    if is_vanishing:
        queue_free()
