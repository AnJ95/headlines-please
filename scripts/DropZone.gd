extends Control

var current_state = 0
var max_state = 2
const padX = 10;
const padY = 10;


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
	current_state = 1
	
	var headlines = ["Ambassador dead", "Ambassador killed", "This is war"]
	var headlineScene = load("res://scenes/Headline.tscn")
	
	var curY = padY;
	
	for headline in headlines:
		var headlineNode = headlineScene.instance()
		get_node("State_1").add_child(headlineNode)
		
		headlineNode.init(Vector2(padX, curY), headline, self, "goto_state_2")
		curY += headlineNode.get_end().y - headlineNode.get_begin().y + padY
		
	show_current_state()

# This means headline has been selected
func goto_state_2(headline):
	current_state = 2
	
	get_node("State_2/Headline").init(Vector2(padX, padY), headline, null, null)
	show_current_state()

# This means everything is done
func goto_state_3():
	current_state = 3
	show_current_state()

