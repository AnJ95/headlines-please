extends Control

const Message = preload("res://scripts/model/Message.gd")

export(PackedScene) var InformationScene
export(Vector2) var anchor_pos
export(int, "TWEET", "NOTE", "PHAX") var message_type
export var max_messages = 3
export var information_padding = 7
export var set_to_back = false

var nodes = []
var queue = []
var currently_rolling = null

onready var audio_stream_player = get_node("AudioStreamPlayer")
onready var animation_player = get_node("AnimationPlayer")

func on_message_arrived(message):
    if message.type == message_type:
        queue.push_back(message)
    
func on_day_ended(world):
    nodes = []

func remove(node):
    nodes.remove(node)

func _process(delta):
    if not queue.empty() and currently_rolling == null:
        var message = queue.pop_front()
        add(message)
    
    if currently_rolling != null:
        for n in nodes:
            n.rect_position.y = n.get_cached_y() - currently_rolling.get_current_height()

func add(message):
    # create and init child
    var node = InformationScene.instance()
    node.rect_position = anchor_pos
    node.init(message)
    node.set_manager(self)
    
    # add child to right position
    add_child(node)
    if set_to_back:
        node.get_parent().move_child(node, 0)
    
    currently_rolling = node
    
    audio_stream_player.play()
    
    #for n in nodes:
    #    n.rect_position -= Vector2(0, node.rect_size.y)
    
    #while nodes.size() > max_messages:
    #    nodes.pop_front().queue_free()

func done_rolling():
    nodes.append(currently_rolling)
    currently_rolling = null
    for n in nodes:
        n.on_next_information()
        n.cache_y()
    