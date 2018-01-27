extends Control

var isMouseIn = false
var isDragging = false
var startMousePos
var startThisPos

func _ready():
	connect("mouse_entered", self, "on_mouse_entered")
	connect("mouse_exited", self, "on_mouse_exited")

func _process(delta):
	if isMouseIn:
		if Input.is_mouse_button_pressed(BUTTON_LEFT):
			if not isDragging:
				internal_start_drag()
			isDragging = true
			internal_move_drag();
		else:
			if isDragging:
				internal_stop_drag()
			isDragging = false

func internal_move_drag():
	rect_position = startThisPos + (get_viewport().get_mouse_position() - startMousePos)
	move_drag()
	
func move_drag():
	pass
	
func start_drag():
	pass

func stop_drag():
	pass
	
func move_to_top():
	get_parent().move_child(self, get_parent().get_child_count() - 1)
	pass
	
func on_mouse_entered():
	isMouseIn = true

func on_mouse_exited():
	isMouseIn = false

func internal_start_drag():
	startMousePos = get_viewport().get_mouse_position()
	startThisPos = Vector2(rect_position.x, rect_position.y)
	move_to_top()
	start_drag()

func internal_stop_drag():
	stop_drag()