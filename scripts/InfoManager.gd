extends Control

const InfoScene = preload("res://scenes/Info.tscn")

func _on_Main_dawn_of_a_new_day( world ):
    print("doand")
    for s in world.current_scenarios:
        var scenario = world.current_scenarios[s]
        for m in range(scenario.messages.size()):
            var message = scenario.messages[m]
            print(message)
            var info_node = InfoScene.instance()
            add_child(info_node)
            info_node.init( message.get_text(world, scenario.countries), m, s)
