extends Control

const Message = preload("res://scripts/model/Message.gd")
const NoteScene = preload("res://scenes/Note.tscn")
onready var Draggables = get_node("/root/Main/Draggables")

func _on_Main_message_arrived(message):
    if message.type == Message.NOTE:
        var node = NoteScene.instance()
        node.init(message)
        Draggables.add_child(node)

func _on_Main_day_started(world):
    pass # replace with function body

func _on_Main_day_ended(world):
    pass # replace with function body
