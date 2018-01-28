extends "res://scripts/Draggable.gd"

var minY
const scrollHeight = 200
var maxY
var handIns = []
var isVacuuming = false

func _ready():
	minY = rect_position.y
	maxY = minY + scrollHeight
	
func move_drag():
	rect_position.x = startThisPos.x
	if rect_position.y < minY:
		rect_position.y = minY
	if rect_position.y > maxY:
		rect_position.y = maxY
	
func start_drag():
	pass

func stop_drag():
	if rect_position.y - minY > scrollHeight / 2:
		rect_position.y = maxY # TODO animate
		isVacuuming = true
	else:
		rect_position.y = minY # TODO animate
		isVacuuming = false



func handIn(draggable):
	handIns.append(draggable)
	
	