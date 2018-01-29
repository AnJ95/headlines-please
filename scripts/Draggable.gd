extends Control

var isMouseIn = false
var isDragging = false
var startMousePos
var startThisPos
var Airmail
var root

var selected_droppable = null

func _ready():
    root = get_node("/root/Main/Draggables") 
    Airmail = get_node("/root/Main/Draggables/Airmail")
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
    
    #var infoManager = get_tree().get_current_scene().get_node("InfoArea")
    var i = root.get_child_count() - 1
    while i >= 0:
        var droppable = root.get_children()[i]
        i -= 1
        if (droppable.is_in_group("droppable")):
            if (droppable.get_global_rect().has_point(get_viewport().get_mouse_position())):
                if droppable.can_drop(self):
                    print("Now hovering")
                    droppable.hovering_now()
                    selected_droppable = droppable
                    return
            else:
                droppable.not_hovering()    
                
    var selected_droppable = null
    
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
    if selected_droppable != null:
        self.rect_position -= selected_droppable.rect_position - get_parent().rect_position
        self.get_parent().remove_child(self)
        selected_droppable.add_child(self)
        selected_droppable.internal_on_drop(self)
    stop_drag()