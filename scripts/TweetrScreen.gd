extends Control


var time_left

const MIN_CHANGE_TIME = 0.03
const MAX_CHANGE_TIME = 0.09

onready var screen_container = get_node("random_switch")
onready var screen_num = screen_container.get_child_count()

func _ready():
    set_random_time()
    
func set_random_time():
    time_left = randf() * (MAX_CHANGE_TIME - MIN_CHANGE_TIME) + MIN_CHANGE_TIME
    
func set_random_screen():
    var s = randi() % screen_num
    for i in range(screen_num):
        screen_container.get_child(i).visible = i == s

func _process(delta):
    time_left -= delta
    if time_left < 0:
        set_random_screen()
        set_random_time()