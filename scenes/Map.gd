extends "res://scripts/Draggable.gd"

var minY
const scrollHeight = 200
var maxY

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
    pass
    
func update(countries):
    for country in countries:
        print("Country" + country.name)
        get_node("Country" + country.name).update(country)
    pass