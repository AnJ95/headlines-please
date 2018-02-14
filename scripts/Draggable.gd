extends Control

var isMouseIn = false
var isDragging = false
var startMousePos
var startThisPos

var enabled = true
var containing_droppable = null
var hovering_droppable = null
onready var Root = get_node("/root/Main/Draggables") 

func _init():
    connect("mouse_entered", self, "on_mouse_entered")
    connect("mouse_exited", self, "on_mouse_exited")

func _process(delta):
    if not enabled:
        return
    if not can_drag_now():
        isDragging = false
        return
    if isMouseIn:
        if Input.is_mouse_button_pressed(BUTTON_LEFT):
            if not isDragging and not Root.is_dragging_sth:
                isDragging = true
                Root.is_dragging_sth = true
                internal_start_drag()
        else:
            if isDragging:
                isDragging = false
                Root.is_dragging_sth = false
                internal_stop_drag()
    
    if isDragging:
        internal_move_drag();

        
    
# overwrite this
func move_drag():
    pass

# overwrite this
func start_drag():
    pass

# overwrite this
func stop_drag():
    pass
    
# overwrite this
func on_drop(droppable):
    pass
    
# overwrite this
func on_drop_in_root():
    pass

# overwrite this
func can_drag_now():
    return true
    
func move_to_top():
    if get_parent() != null:
        get_parent().move_child(self, get_parent().get_child_count() - 1)
    pass
    
func on_mouse_entered():
    isMouseIn = true

func on_mouse_exited():
    if not isDragging:
        isMouseIn = false

func internal_move_drag():
    rect_position = startThisPos + (get_viewport().get_mouse_position() - startMousePos)
    move_drag()
    var i = Root.get_child_count() - 1

    hovering_droppable = null
    while i >= 0:
        var droppable = Root.get_children()[i]
        i -= 1
        if (droppable.is_in_group("droppable")):
            if (droppable.get_global_rect().has_point(get_viewport().get_mouse_position())):
                if droppable.can_drop(self):
                    droppable.hovering_now(self)
                    hovering_droppable = droppable
                    break
    reset_droppable_hovering()
    
    var p = get_parent()
    var count = p.get_child_count()
    if p.get_child(count - 1) != self:
        p.move_child(self, count - 1)
        
    

# calls not_hover() on all droppables
func reset_droppable_hovering():
    for droppable in get_tree().get_nodes_in_group("droppable"):
        if droppable != hovering_droppable:
            droppable.not_hovering()    
    
    
func internal_start_drag():
    if is_in_droppable():
        internal_on_undrop()
    startMousePos = get_viewport().get_mouse_position()
    startThisPos = Vector2(rect_position.x, rect_position.y)
    move_to_top()
    start_drag()

func internal_stop_drag():
    reset_droppable_hovering()
    if is_hovering_over_droppable():
        internal_on_drop(hovering_droppable)
    else:
        on_drop_in_root()
    stop_drag()
    
func internal_on_drop(droppable):
    print("drop")
    containing_droppable = droppable
    
    self.rect_position -= - self.get_parent().get_global_rect().position + droppable.get_global_rect().position
    
    self.get_parent().remove_child(self)
    droppable.drop_root.add_child(self)
    
    droppable.internal_on_enter(self)

    on_drop(droppable)
    
func internal_on_undrop():
    print("undrop")
    containing_droppable.internal_on_leave(self)
    
    self.rect_position = get_global_rect().position - Root.get_global_rect().position
    
    containing_droppable.drop_root.remove_child(self)
    Root.add_child(self)
    
    containing_droppable = null
    hovering_droppable = null

func is_hovering_over_droppable():
    return hovering_droppable != null
    
func is_in_droppable():
    return containing_droppable != null