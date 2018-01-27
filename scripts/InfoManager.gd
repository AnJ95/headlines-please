extends Control

const InfoScene = preload("res://scenes/Info.tscn")

func _on_Main_day_ended(world):
    for c in get_children():
        c.queue_free()

func _on_Main_day_started(world):
    return

func _on_Main_message_arrived(message):
    var info_node = InfoScene.instance()
    add_child(info_node)
    info_node.init(message)
