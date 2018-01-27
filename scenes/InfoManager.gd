extends Control

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	var infoScene = load("res://scenes/Info.tscn")
	for i in range(10):
		var infoNode = infoScene.instance()
		add_child(infoNode)
		infoNode.init("goto_state_2 goto_state_2 goto_state_2 goto_state_2 goto_state_2 goto_state_2 goto_state_2 goto_state_2 goto_state_2 ")

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
