extends "res://scripts/ScrollInformation.gd"

func _ready():
    pass
    add_to_group("phax")
    reset()
    rect_position.y += rect_size.y # to counter ScrollMessageManagers behavior


# from Draggable
func start_drag():
    manager.remove(self)
        
    

