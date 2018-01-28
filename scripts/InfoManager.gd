extends Control

const Message = preload("res://scripts/model/Message.gd")
const InfoScene = preload("res://scenes/Info.tscn")

func _on_Main_message_arrived(message):
    if message.type == Message.NOTE:
        var info_node = InfoScene.instance()
        info_node.init(message)
        get_node("/root/Main/Draggables").add_child(info_node)

