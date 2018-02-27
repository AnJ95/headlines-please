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
        
        update_headlines()
 
func update_headlines():
    
    if contained_draggables.size() < MIN_INFOS:
        for node in headline_container.get_children():
            node.disappear()
            notified_headlines_count -= 1
        headlines = []
        return
    
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
            for node in headline_container.get_children():
                if node.model == headline:
                    node.disappear()
                    notified_headlines_count -= 1
                    
    headlines = new_headlines

func add_headline(model):
    var headlineNode = headlineScene.instance()
    headline_container.add_child(headlineNode)    
    headlineNode.init(model, self, "goto_finalized")
    headlineNode.register_dropzone(self)
    headlineNode.appear()


# from Droppable
func on_leave(draggable):
    unpin(draggable)
    update_headlines()
    
func unpin(draggable):
    if draggable.pin != null:
        draggable.pin.remove()
        draggable.pin = null
 
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
    node.modulate = Color(1,1,1,1)
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
    
    # Move all Notes downwards if they overlap with headlines
    cur_headlines_size = curY
    for draggable in contained_draggables:
        move_draggable_in(draggable)
        
func move_draggable_in(draggable):
    var pin_pos_original = draggable.rect_position + Vector2(draggable.rect_size.x / 2, 5)
    var pin_pos = pin_pos_original
    
    var minX = INFO_POS_ADJUST_MIN_PADDING
    var maxX = rect_size.x - INFO_POS_ADJUST_MIN_PADDING
    var minY = headline_container.rect_position.y + cur_headlines_size
    var maxY = rect_size.y - INFO_POS_ADJUST_MIN_PADDING
    
    if (pin_pos_original.x < minX):
        pin_pos.x = minX
    if (pin_pos_original.x > maxX):
        pin_pos.x = maxX
    if (pin_pos_original.y < minY):
        pin_pos.y = minY
    if (pin_pos_original.y > maxY):
        pin_pos.y = maxY
    
    if pin_pos.x != pin_pos_original.x or pin_pos.y != pin_pos_original.y:
        var start = draggable.rect_position
        var end = start + pin_pos - pin_pos_original
        if draggable.pin != null:
            tween.interpolate_property(draggable.pin, "rect_position", pin_pos_original, pin_pos, INFO_POS_ADJUST_TIME, Tween.TRANS_QUAD, Tween.EASE_IN_OUT)
        tween.interpolate_property(draggable, "rect_position", start, end, INFO_POS_ADJUST_TIME, Tween.TRANS_QUAD, Tween.EASE_IN_OUT)
        tween.start()
    
    if draggable.pin == null:
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