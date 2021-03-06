extends Control

export var PaperSzene = preload("res://scenes/DropZone.tscn")
export var paper_count = 3

var papers = []

var is_dragging_sth = false

func on_day_started( world ):
    for i in range(paper_count):
        var node = PaperSzene.instance()
        papers.append(node)
        node.rect_position = rand_position()
        get_node("/root/Main/Draggables").add_child(node)

func _process(delta):
    if not Input.is_mouse_button_pressed(BUTTON_LEFT):
        is_dragging_sth = false
                
func rand_position():
    var outer = get_node("/root/Main/Draggables").get_global_rect()
    var inner = get_global_rect()

    return - outer.position + inner.position + Vector2(randf() * inner.size.x, randf() * inner.size.y)