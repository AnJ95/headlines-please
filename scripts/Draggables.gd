extends Control

export var PaperSzene = preload("res://scenes/DropZone.tscn")
export var paper_count = 3

var papers = []

func _on_Main_day_started( world ):
    for p in papers:
        if p != null:
            p.queue_free()
    papers = []
    
    for i in range(paper_count):
        print("create")
        var node = PaperSzene.instance()
        papers.append(node)
        node.rect_position = rand_position()
        get_node("/root/Main/Draggables").add_child(node)

func _on_Main_day_ended( world ):
    pass
    
func rand_position():
    var outer = get_node("/root/Main/Draggables").get_global_rect()
    var inner = get_global_rect()

    return - outer.position + inner.position + Vector2(randf() * inner.size.x, randf() * inner.size.y)

func _on_Main_message_arrived( message ):
    pass # replace with function body
