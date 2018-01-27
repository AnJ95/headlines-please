extends Control

# if this node has been moved to mat
var isSelected = false

const BORDER_COLOR_DEFAULT = Color(0.4, 0.4, 0.4, 1)
const BORDER_COLOR_SELECTED = Color(0.9, 0.3, 0.3, 1)

var isMouseIn = false
var isDragging = false
var startMousePos
var startThisPos

func _ready():
	shuffle_position()
	update_view();
	init("[b]HALLO[/b]")

func init(strContent):
	get_node("RichTextLabel").parse_bbcode(strContent)


func _process(delta):
	if isMouseIn:
		if Input.is_mouse_button_pressed(BUTTON_LEFT):
			if not isDragging:
				start_drag()
			isDragging = true
			move_drag();
		else:
			if isDragging:
				stop_drag()
			isDragging = false

func move_drag():
	rect_position = startThisPos + (get_viewport().get_mouse_position() - startMousePos)

func start_drag():
	startMousePos = get_viewport().get_mouse_position()
	startThisPos = Vector2(rect_position.x, rect_position.y)
	move_to_top()


func stop_drag():
	var mat = get_tree().get_current_scene().get_node("DropZone")
	var infoManager = get_tree().get_current_scene().get_node("InfoManager")
	isSelected = get_global_rect().intersects(mat.get_global_rect())
	update_view();

func update_view():
	if isSelected:
		get_node("Border").color = BORDER_COLOR_SELECTED
	else:
		get_node("Border").color = BORDER_COLOR_DEFAULT

func move_to_top():
	get_parent().move_child(self, get_parent().get_child_count() - 1)
	pass

func _on_Info_mouse_entered():
	isMouseIn = true

func _on_Info_mouse_exited():
	isMouseIn = false

func shuffle_position():
	var outer = get_parent().get_global_rect()
	var inner = get_global_rect()

	var maxW = outer.size.x - inner.size.x
	var maxH = outer.size.y - inner.size.y

	rect_position = Vector2(randf() * maxW, randf() * maxH)
