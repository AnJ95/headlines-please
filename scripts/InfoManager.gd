extends Control

const Message = preload("res://scripts/model/Message.gd")
const InfoScene = preload("res://scenes/Info.tscn")
onready var Draggables = get_node("/root/Main/Draggables")

func _on_Main_message_arrived(message):
    if message.type == Message.NOTE:
        var info_node = InfoScene.instance()
        info_node.init(message)
        Draggables.add_child(info_node)



func _on_Main_day_started( world ):
    pass # replace with function body


func _on_Main_day_ended( world ):
    pass # replace with function body
