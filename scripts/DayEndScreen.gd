extends Control

const timeSlot = 2.5
var isRunning = false
var timeYet = 0
var currentSlot = -1
var world
var doneScenarios = []

const ReportPage = preload("res://scenes/ReportPage.tscn")
const DropZone = preload("res://scripts/DropZone.gd")

onready var Airmail = get_node("/root/Main/Draggables/Airmail")
#onready var DraggableHolder = get_node("folder/DraggableHolder")
#onready var Label = get_node("folder/Label")
#onready var Heading = get_node("folder/Heading")

export(Array, NodePath) var leaving_nodes = []
    

func next_page():
    currentSlot += 1
    if (currentSlot >= Airmail.contained_draggables.size()):
        # if done showing all draggables
        isRunning = false
        world.next_day()
        Airmail.clear_children()
        hide()
    else:
        var draggable = Airmail.contained_draggables[currentSlot]
        
        var reportPage = ReportPage.instance()
        add_child(reportPage)
        init_report_page(reportPage, draggable)

func init_report_page(reportPage, draggable):
    
    reportPage.rect_position = Vector2(528, 10)
    
    #init(draggable, report_num, item_num, item_max_num, countries, country_reader_changes, total_reader_change, financial_impact, note)
    reportPage.init(
        draggable,
        world.day,
        currentSlot + 1,
        Airmail.contained_draggables.size(),
        world.countries,
        [], # TODO get/calculate them!
        2, # TODO get/calculate
        12, # TODO get/calculate
        "Solid news, bro" # TODO get/calculate
        )
    

func show():
    for leaving_node in leaving_nodes:
        get_node(leaving_node).animation_player.play("leave")
    self.visible = true # TODO animate fade in
    
func hide():
    self.visible = false # TODO animate fade out
    for leaving_node in leaving_nodes:
        get_node(leaving_node).animation_player.play_backwards("leave")

#func show_draggable(draggable):
#    draggable.rect_position = Vector2(-draggable.rect_size.x / 2, -draggable.rect_size.y / 2)
#    DraggableHolder.add_child(draggable)
#
#    var labelStr
#
#    if draggable_is_valid(draggable):
#        var scenario = draggable.selected_headline.scenario_name
#        if (doneScenarios.has(scenario)):
#            labelStr = "Redundant Article!"
#        else:
#            doneScenarios.append(scenario)
#            var rating = round(world.broadcast_headline(draggable.selected_headline))
#            # TODO better updating
#            get_node("/root/Main/Draggables/Map").update(world)
#            labelStr = "Readers "
#            if rating > 0:
#                labelStr += "+"
#            labelStr += str(rating)
#    else:
#        labelStr = "..."
#
#    Label.set_text(labelStr)

func get_rating(draggable):
    if self is DropZone and self.selected_headline != null:
        return 0
    else:
        return randi(10)

func draggable_is_valid(draggable):
    return draggable is DropZone and draggable.selected_headline != null

func on_day_ended(world):
    isRunning = true
    timeYet = 0
    currentSlot = -1
    self.world = world
    doneScenarios = []
    
    show()
    
    currentSlot = -1
    next_page()

    
    