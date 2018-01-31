extends Control

const Message = preload("res://scripts/model/Message.gd")

export(PackedScene) var InformationScene
export(Vector2) var anchor_pos
export(int, "TWEET", "NOTE", "PHAX") var message_type
export var max_messages = 3
export var set_to_back = false

var nodes = []

onready var audio_stream_player = get_node("AudioStreamPlayer")
onready var animation_player = get_node("AnimationPlayer")

func on_message_arrived(message):
    if message.type == message_type:
        add(message)
    
func on_day_ended(world):
    nodes = []

func remove(node):
    nodes.remove(node)
        
func add(message):
    var node = InformationScene.instance()
    node.rect_position = anchor_pos
    node.init(message)
    add_child(node)
    if set_to_back:
        node.get_parent().move_child(node, 0)
    nodes.append(node)
    
    audio_stream_player.play()
    
    for n in nodes:
        n.rect_position -= Vector2(0, node.rect_size.y)
    
    while nodes.size() > max_messages:
        nodes.pop_front().queue_free()
