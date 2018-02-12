extends "res://scripts/Droppable.gd"

const Pin = preload("res://scenes/Pin.tscn")
const headlineScene = preload("res://scenes/Headline.tscn")
const padX = 18
const initial_padY = 40
const padY = 4
const INFO_POS_ADJUST_TIME = 0.25
const INFO_POS_ADJUST_MIN_PADDING = 10

onready var anim_root = $animation_root
onready var state0 = anim_root.get_node("State_0")
onready var state1 = anim_root.get_node("State_1")
onready var state2 = anim_root.get_node("State_2")
onready var tween = state0.get_node("Tween")
onready var animationPlayer = $AnimationPlayer

var current_state = 0
var max_state = 2
var selected_headline = null

var notified_headlines_count_max
var notified_headlines_count

func _ready():
    show_current_state()
    add_to_group("dropzone")
    get_tree().get_root().get_node("/root/Main").connect("day_ended", self, "on_day_ended", ["world"])
        

func on_day_ended(node, world):
    if containing_droppable == null:
        queue_free()
    else:
        state0.get_node("TextureButton").visible = false
        state1.get_node("TextureButton2").visible = false
        state2.get_node("TextureButton3").visible = false

# from Droppable
func on_enter(draggable):
    # only one scenario allowed
    if draggable.is_in_group("information"):
        for other in contained_draggables:
            if other.message.scenario != draggable.message.scenario:
                # force undrop
                draggable.internal_on_undrop()
                draggable.isMouseIn = false
                # move info away
                move_draggable_out(draggable)
                # let DropZone shake
                animationPlayer.play("shake")
                return
    move_draggable_in(draggable)
    
   
func move_draggable_in(draggable):
    var pin_pos_original = draggable.rect_position + Vector2(draggable.rect_size.x / 2, 5)
    var pin_pos = pin_pos_original

    if (pin_pos_original.x < INFO_POS_ADJUST_MIN_PADDING):
        pin_pos.x = INFO_POS_ADJUST_MIN_PADDING
    if (pin_pos_original.x > rect_size.x - INFO_POS_ADJUST_MIN_PADDING):
        pin_pos.x = rect_size.x - INFO_POS_ADJUST_MIN_PADDING
    if (pin_pos_original.y < INFO_POS_ADJUST_MIN_PADDING):
        pin_pos.y = INFO_POS_ADJUST_MIN_PADDING
    if (pin_pos_original.y > rect_size.y - INFO_POS_ADJUST_MIN_PADDING):
        pin_pos.y = rect_size.y - INFO_POS_ADJUST_MIN_PADDING
    
    if pin_pos != pin_pos_original:
        var start = draggable.rect_position
        var end = start + pin_pos - pin_pos_original
        tween.interpolate_property(draggable, "rect_position", start, end, INFO_POS_ADJUST_TIME, Tween.TRANS_QUAD, Tween.EASE_IN_OUT)
        tween.start()
    
    var pin = Pin.instance()
    pin.rect_position = pin_pos
    draggable.pin = pin
    state0.add_child(pin)
    
func move_draggable_out(draggable):
    var pos_original = draggable.rect_position + Vector2(draggable.rect_size.x / 2, 5)
    var pos = pos_original

    draggable.fly_away(self, 200)
 
# from Droppable
func on_leave(draggable):
    if draggable.pin != null:
        draggable.pin.remove()
        draggable.pin = null
    
# from Droppable
func accepted_groups():
    return ["note", "tweet", "phax"]

# from Droppable
func accepts_drops_now():
    return current_state == 0
    
func show_current_state():
    move_child(anim_root.get_node("State_" + str(current_state)), get_child_count() - 1)
    for i in range(max_state + 1):
        anim_root.get_node("State_" + str(i)).visible = current_state == i
    

# This means Infos are now selected
# and headline possibilities should be displayed
func goto_state_1():
    current_state = 1
    var world = get_node("/root/Main");
    
    var headlines = []
    for infoNode in contained_draggables:
        for headline in infoNode.message.get_headlines():
            if not headlines.has(headline):
                headlines.append(headline)
 
    initialize_headline_size_adjust_waiting(headlines.size())
    for headline in headlines:
        var headlineNode = headlineScene.instance()
        state1.get_node("headlines").add_child(headlineNode)    
        headlineNode.init(headline, self, "goto_state_2")
        headlineNode.register_dropzone(self)
    show_current_state()

# initialize for waiting for all headlines to adjust size
func initialize_headline_size_adjust_waiting(count_max):
    notified_headlines_count = 0
    notified_headlines_count_max = count_max

func go_back_to_state_0():
    for headline in state1.get_node("headlines").get_children():
        headline.queue_free()
    current_state = 0
    show_current_state()
    
func go_back_to_state_1():
    current_state = 1
    selected_headline = null
    show_current_state()

# This means headline has been selected
func goto_state_2(headline):
    current_state = 2
    selected_headline = headline
    var node = state2.get_node("Headline")
    node.size_adjusted = false
    node.init(headline, null, null)
    node.rect_position = Vector2(padX, initial_padY)
    show_current_state()

# This means everything is done
func goto_state_3():
    current_state = 3
    show_current_state()
    
# called whenever a headline adjusted its size
func notify_size_adjusted():
    if current_state != 1:
        return
    notified_headlines_count += 1
    if notified_headlines_count >= notified_headlines_count_max:
        adjust_headline_positions()

# called when all headlines have adjusted their size and need positioning
func adjust_headline_positions():
    var curY = initial_padY;
    for headline in state1.get_node("headlines").get_children():
        headline.rect_position =  Vector2(padX, curY)
        curY += headline.rect_size.y + padY