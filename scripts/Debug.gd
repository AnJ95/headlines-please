extends Button


func on_clicked():
    print("enter")
    var world = get_node("/root/Main")
    world.time = world.DAY_CYCLE_TIME
