extends Control

var isMouseIn = false
var isDragging = false
var startMousePos
var startThisPos

func _process(delta):
	if isMouseIn:
		if Input.is_mouse_button_pressed(BUTTON_LEFT):
			# If dragging just started
			if not isDragging:
				startMousePos = get_viewport().get_mouse_position()
				startThisPos = Vector2(rect_position.x, rect_position.y)
				move_to_top()
			isDragging = true
			rect_position = startThisPos + (get_viewport().get_mouse_position() - startMousePos)
		else:
			isDragging = false

func move_to_top():

	get_parent().move_child(self, get_parent().get_child_count() - 1)
	pass
	

func _on_Info_mouse_entered():
	isMouseIn = true


func _on_Info_mouse_exited():
	isMouseIn = false
