extends Control

const InfoScene = preload("res://scenes/Info.tscn")

func _on_Main_message_arrived(message):
    var info_node = InfoScene.instance()
    get_node("/root/Main/Draggables").add_child(info_node)
    info_node.init(message)
