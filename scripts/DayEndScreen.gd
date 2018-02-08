extends Control

var isRunning = false
var currentSlot = -1
var world
var doneScenarios = []

const ReportPage = preload("res://scenes/ReportPage.tscn")
const DropZone = preload("res://scripts/DropZone.gd")

onready var Airmail = get_node("/root/Main/Draggables/Airmail")

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
    
    
    # prepare values before they are changed
    var country_reader_changes = []
    for country in world.countries:
        country_reader_changes.append(-country.get_readers())
    var total_reader_change = -world.get_total_readers()
    var financial_impact = -world.get_current_bilances()
    
    # broadcast message to countries
    if draggable_is_valid(draggable):
        world.broadcast_headline(draggable.selected_headline)
        
    # calculate changes using old and new values
    for country_id in range(world.countries.size()):
        country_reader_changes[country_id] = round(10 * (country_reader_changes[country_id] + world.countries[country_id].get_readers())) / 10
    total_reader_change += world.get_total_readers()
    financial_impact += world.get_current_bilances()
    
    #init(dayEndScreen, draggable, report_num, item_num, item_max_num, countries, country_reader_changes, total_reader_change, financial_impact, note)
    reportPage.init(
        self,
        draggable,
        world.day,
        currentSlot + 1,
        Airmail.contained_draggables.size(),
        world.countries,
        country_reader_changes,
        round(10 * total_reader_change) / 10,
        round(10 * financial_impact) / 10,
        "Solid news, bro" # TODO get
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
    currentSlot = -1
    self.world = world
    doneScenarios = []
    
    show()
    
    currentSlot = -1
    next_page()

    
    