extends Control

const InfoScene = preload("res://scenes/Info.tscn")

func _on_Main_dawn_of_a_new_day( world ):
    for s in world.current_scenarios:
        var scenario = world.current_scenarios[s]
        for m in range(scenario.messages.size()):
            var message = scenario.messages[m]
            var info_node = InfoScene.instance()
            add_child(info_node)
            info_node.init(message)
