extends "res://scripts/Draggable.gd"

var selectedDropZone = null

const BORDER_COLOR_DEFAULT = Color(0.4, 0.4, 0.4, 1)
const BORDER_COLOR_SELECTED = Color(0.9, 0.3, 0.3, 1)

const PADDING = 5
const BORDER = 2

var timeYet = 0

var hasSetSize = false

export var width = 120
var message

onready var outer = get_node("/root/Main/InfoArea")

func _ready():
    add_to_group("info")
    reset()
    get_node("Label").rect_size = Vector2(width, 1000)
    get_node("Label").set_text(message.text)

func init(message):
    self.message = message
    
func reset():
    shuffle_position()
    update_view()

func _process(delta):
    
    if not hasSetSize:
        timeYet += delta 
        if timeYet > 0.1:
            hasSetSize = true
            
            var size = Vector2(width, get_node("Label").get_combined_minimum_size().y)
            
            rect_size = size + Vector2(2*PADDING + 2*BORDER, 2*PADDING + 2*BORDER)
            
            get_node("Border").rect_position = Vector2(0, 0)
            get_node("Border").rect_size = size + Vector2(2*PADDING + 2*BORDER, 2*PADDING + 2*BORDER)
            
            #get_node("Background").rect_position = Vector2(BORDER, BORDER)
            #get_node("Background").rect_size = size + Vector2(2*PADDING, 2*PADDING)
            
            get_node("Label").rect_position = Vector2(BORDER + PADDING, BORDER + PADDING)
            get_node("Label").rect_size = size
            
    pass

func move_drag():
    pass

func start_drag():
    pass


func stop_drag():
    
    var draggables = get_node("/root/Main/Draggables")
    
    #var infoManager = get_tree().get_current_scene().get_node("InfoArea")
    
    var i = draggables.get_child_count() - 1
    while i >= 0:
        var child = draggables.get_children()[i]
        i -= 1
        if (child.is_in_group("dropzone")):
            print(str(i) + ": " + str(child))
            if child.current_state == 0:
                if (child.get_global_rect().has_point(get_viewport().get_mouse_position())):
                    selectedDropZone = child
                    add_to_dropzone(child)
                    update_view();
                    return
    selectedDropZone = null
    add_to_draggables()


func add_to_dropzone(dropZone):
    self.rect_position -= dropZone.rect_position - get_parent().rect_position
    get_parent().remove_child(self)
    dropZone.add_child(self)
    
func add_to_draggables():
    var draggables = get_node("/root/Main/Draggables")
    self.rect_position -= draggables.rect_position - get_parent().rect_position
    get_parent().remove_child(self)
    draggables.add_child(self)

func update_view():
    if selectedDropZone != null:
        get_node("Border").color = BORDER_COLOR_SELECTED
    else:
        get_node("Border").color = BORDER_COLOR_DEFAULT


func shuffle_position():
    var outer = get_node("/root/Main/InfoArea").get_global_rect()
    var inner = get_global_rect()

    var maxW = outer.size.x - inner.size.x
    var maxH = outer.size.y - inner.size.y

    rect_position = Vector2(randf() * maxW, randf() * maxH)


func can_be_vacuumed():
    return true