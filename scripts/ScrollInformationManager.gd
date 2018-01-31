extends Control

const Message = preload("res://scripts/model/Message.gd")

export(PackedScene) var InformationScene
export(Vector2) var anchor_pos
export(int, "TWEET", "NOTE", "PHAX") var message_type
export var max_messages = 3
export(NodePath) var root = ""
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
    queue = []
    currently_rolling = null

func remove(node):
    nodes.erase(node)

func _process(delta):
    if not queue.empty() and currently_rolling == null:
        var message = queue.pop_front()
        add(message)
    
    if currently_rolling != null:
        for n in nodes:
            n.adjust_position(currently_rolling.get_current_height(), currently_rolling.get_maximum_height())

func add(message):
    # create and init child
    var node = InformationScene.instance()
    node.rect_position = anchor_pos
    node.init(message)
    node.set_manager(self)
    
    # add child to right position
    get_node(root).add_child(node)
    if set_to_back:
        node.get_parent().move_child(node, 0)
    
    currently_rolling = node
    
    audio_stream_player.play()

func done_rolling():
    nodes.append(currently_rolling)
    currently_rolling = null
    for n in nodes:
        n.on_next_information()
    while nodes.size() > max_messages:
        var node = nodes.pop_front()
        remove(node)
        node.queue_free()
    