extends Control

var current_state = 0
var max_state = 2
const padX = 18;
const initial_padY = 40
const padY = 4;

const headlineScene = preload("res://scenes/Headline.tscn")

func _ready():
	show_current_state()
	pass


func show_current_state():
	print("showing state " + str(current_state))
	
	move_child(get_node("State_" + str(current_state)), get_child_count() - 1)
	for i in range(max_state + 1):
		get_node("State_" + str(i)).visible = current_state == i
	

# This means Infos are now selected
# and headline possibilities should be displayed
func goto_state_1():
	
	var hasMinOne = false
	for infoNode in get_node("/root/Main/InfoManager").get_children():
		if infoNode.isSelected:
			hasMinOne = true
			break
	if not hasMinOne:
		return
			
	current_state = 1
	
	var world = get_node("/root/Main");
	
	var headlines = []
	for infoNode in get_node("/root/Main/InfoManager").get_children():
		if infoNode.isSelected:
			infoNode.visible = false
			for headline in infoNode.message.get_headlines():
				headlines.append(headline)
	
	var curY = initial_padY;
	
	for headline in headlines:
		var headlineNode = headlineScene.instance()
		get_node("State_1/headlines").add_child(headlineNode)
		
		headlineNode.init(headline, Vector2(padX, curY), self, "goto_state_2")
		curY += headlineNode.get_end().y - headlineNode.get_begin().y + padY
		
	show_current_state()
	
func go_back_to_state_0():
	for infoNode in get_node("/root/Main/InfoManager").get_children():
		if infoNode.isSelected:
			infoNode.visible = true
			infoNode.isSelected = false
			infoNode.update_view()
			infoNode.shuffle_position()
	for headline in get_node("State_1/headlines").get_children():
		headline.queue_free()
	current_state = 0
	show_current_state()
	
func go_back_to_state_1():
	current_state = 1
	show_current_state()

# This means headline has been selected
func goto_state_2(headline):
	current_state = 2
	
	get_node("State_2/Headline").init(headline, Vector2(padX, initial_padY), null, null)
	show_current_state()

# This means everything is done
func goto_state_3():
	current_state = 3
	show_current_state()

