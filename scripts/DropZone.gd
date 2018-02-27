extends "res://scripts/Droppable.gd"

const Pin = preload("res://scenes/Pin.tscn")
const headlineScene = preload("res://scenes/Headline.tscn")
const padY = 4
const INFO_POS_ADJUST_TIME = 0.25
const INFO_POS_ADJUST_MIN_PADDING = 10
const MIN_INFOS = 3

onready var anim_root = $animation_root
onready var unfinalized = anim_root.get_node("unfinalized")
onready var finalized = anim_root.get_node("finalized")
onready var headline_container = unfinalized.get_node("headlines")
onready var tween = unfinalized.get_node("Tween")
onready var animationPlayer = $AnimationPlayer

var cur_headlines_size = 0

var headlines = []
var is_finalized = false
var selected_headline = null

var notified_headlines_count_max = 0
var notified_headlines_count = 0

func _ready():
    show_current_state()
    add_to_group("dropzone")
    get_tree().get_root().get_node("/root/Main").connect("day_ended", self, "on_day_ended", ["world"])
        
func on_day_ended(node, world):
    if containing_droppable == null:
        queue_free()
    else:
        finalized.get_node("TextureButton").visible = false

# from Droppable
func on_enter(draggable):
    # must be in correct group
    if draggable.is_in_group("information"):
        # only one scenario allowed
        for other in contained_draggables:
            if other.message.scenario != draggable.message.scenario:
                refuse_draggable(draggable)
                return
        move_draggable_in(draggable)
        
        #if contained_draggables.size() >= MIN_INFOS:
        update_headlines()
        # TODO start showing headlines
 
func update_headlines():
    var new_headlines = []
    for infoNode in contained_draggables:
        for headline in infoNode.message.get_headlines():
            if not new_headlines.has(headline):
                new_headlines.append(headline)
    
    notified_headlines_count_max = new_headlines.size()
    
    # check for new headlines
    for headline in new_headlines:
        if not headlines.has(headline):
            add_headline(headline)
            
    # check for removed headlines
    for headline in headlines:
        if not new_headlines.has(headline):
            for node in headline_container:
                if node.model == headline:
                    headline_container.remove_child(node)
            
    headlines = new_headlines

func add_headline(model):
    var headlineNode = headlineScene.instance()
    headline_container.add_child(headlineNode)    
    headlineNode.init(model, self, "goto_finalized")
    headlineNode.register_dropzone(self)


# from Droppable
func on_leave(draggable):
    if draggable.pin != null:
        draggable.pin.remove()
        draggable.pin = null
        
    if contained_draggables.size() < MIN_INFOS:
        is_finalized = is_finalized
        # TODO hide headlines
 
# from Droppable
func accepted_groups():
    return ["note", "tweet", "phax"]

# from Droppable
func accepts_drops_now():
    return not is_finalized
    
func show_current_state():
    if is_finalized:
        unfinalized.visible = false
        finalized.visible = true
    else:
        unfinalized.visible = true
        finalized.visible = false

# initialize for waiting for all headlines to adjust size
func initialize_headline_size_adjust_waiting(count_max):
    notified_headlines_count = 0
    notified_headlines_count_max = count_max

func go_back_to_unfinalized():
    is_finalized = false
    show_current_state()

# This means headline has been selected
func goto_finalized(headline):
    is_finalized = true
    selected_headline = headline
    var node = finalized.get_node("Headline")
    node.size_adjusted = false
    node.init(headline, null, null)
    node.rect_position = headline_container.rect_position
    show_current_state()


# called whenever a headline adjusted its size
func notify_size_adjusted():
    if is_finalized:
        return
    notified_headlines_count += 1
    if notified_headlines_count >= notified_headlines_count_max:
        adjust_headline_positions()

# called when all headlines have adjusted their size and need positioning
func adjust_headline_positions():
    var curY = 0;
    for headline in unfinalized.get_node("headlines").get_children():
        headline.rect_position =  Vector2(0, curY)
        curY += headline.rect_size.y + padY
        
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
    unfinalized.add_child(pin)

func refuse_draggable(draggable):
    # force undrop
    draggable.internal_on_undrop()
    draggable.isMouseIn = false
    # move info away
    move_draggable_out(draggable)
    # let DropZone shake
    animationPlayer.play("shake")
    
func move_draggable_out(draggable):
    var pos_original = draggable.rect_position + Vector2(draggable.rect_size.x / 2, 5)
    var pos = pos_original

    draggable.fly_away(self, 200)