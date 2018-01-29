extends Control

const Message = preload("res://scripts/model/Message.gd")

export(PackedScene) var MessageScene
export(Vector2) var anchor_pos
export(int, "TWEET", "NOTE", "PHAX") var message_type
export var max_messages = 3
export var set_to_back = false

var nodes = []

onready var audio_stream_player = get_node("AudioStreamPlayer")
onready var animation_player = get_node("AnimationPlayer")

func _on_Main_day_ended(world):
    pass

func _on_Main_day_started(world):
    for n in nodes:
        n.queue_free()
    nodes = []

func _on_Main_message_arrived(message):
    if message.type == message_type:
        add(message)
    
func add(message):
    var message_node = MessageScene.instance()
    message_node.init(message)
    add_child(message_node)
    if set_to_back:
        message_node.get_parent().move_child(message_node, 0)
    nodes.append(message_node)
    message_node.rect_position = anchor_pos
    
    audio_stream_player.play()
    
    for n in nodes:
        n.rect_position -= Vector2(0, message_node.rect_size.y)
    
    while nodes.size() > max_messages:
        nodes.pop_front().queue_free()
