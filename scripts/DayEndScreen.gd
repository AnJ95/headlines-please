extends Control

const INITIAL_WAIT = 1.2
const MIN_PAGE_TIME = 2
var isRunning = false
var currentSlot = -2
var world
var time = 0
var doneScenarios = []

const ReportPage = preload("res://scenes/ReportPage.tscn")
const DropZone = preload("res://scripts/DropZone.gd")
const NOTE_UNFINISHED = [
"You need to finish your article before handing it in...",
"I can't anticipate what you are thinking, next time finish your work!",
"How did this unfinished newspaper get here?",
]
const NOTE_NO_NEWSPAPER = [
"The Airmail is for articles only...",
"How did this junk get inside here?",
"This gotta be a joke, right?",
"What kind of humor is that?"
]
const NOTE_REDUNDANT_ARTICLE = [
"Didn't we report about this in one of the previous articles?",
"You do realize, that you wrote two articles about the same topic, right?",
]
const NOTE_ORDERED_BY_IMPACT = [
"Are you trying to get the people to hate us?",
"What were you thinking with this one?",
"You have to foresee what the people want to read. This is not it!",
"That headline was boring, wasn't it?",
"That didn't quite hit the spot",
"Seems like the people didn't really notice this article.",
"You managed to convince a few people with that headline.",
"That article is going in the right direction.",
"A solid article, further establishing our newspaper",
"Looks like you really managed to hit the nerve of most people!",
"I have to admit this piece of art could be worth the pulitzer price!"
]

onready var Airmail = get_node("/root/Main/Draggables/Airmail")

export(Array, NodePath) var leaving_nodes = []

var has_clicked = false

func _process(delta):
    time += delta
    if currentSlot == -1:
        if time > INITIAL_WAIT:
            time = 0
            has_clicked = false
            next_page()
    elif currentSlot >= 0:
        if time > MIN_PAGE_TIME and has_clicked:
            time = 0
            has_clicked = false
            next_page() 
          
func on_click():
    has_clicked = true

func next_page():
    currentSlot += 1
    if (currentSlot >= Airmail.contained_draggables.size()):
        # if done showing all draggables
        isRunning = false
        world.next_day()
        Airmail.clear_children()
        hide()
        currentSlot = -2
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
    
    # broadcast message to countries if valid
    if draggable_is_valid(draggable):
        if not doneScenarios.has(draggable.selected_headline.scenario.name):
            world.broadcast_headline(draggable.selected_headline)
    # TODO better updating
    get_node("/root/Main/Draggables/Map").update(world)
    
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
        get_custom_note(draggable, total_reader_change / world.get_total_population())
        )    
    
    # add scenario name to list
    if draggable_is_valid(draggable):
        if not doneScenarios.has(draggable.selected_headline.scenario.name):
            doneScenarios.append(draggable.selected_headline.scenario.name)


func get_random_in(array):
    return array[randi() % array.size()]


func get_custom_note(draggable, total_reader_change_in_percent):
    if not draggable is DropZone:
        return get_random_in(NOTE_NO_NEWSPAPER)
    if draggable is DropZone and draggable.selected_headline == null:
        return get_random_in(NOTE_UNFINISHED)
    if doneScenarios.has(draggable.selected_headline.scenario.name):
        return get_random_in(NOTE_REDUNDANT_ARTICLE)
    
    # first amplify effect * 10
    # Then norm from [-1,1] to [0,1] (ignoring prev amplification)
    # Then norm to [0, amount of notes]
    var score = round((((total_reader_change_in_percent * 15) / 2 + 0.5) * NOTE_ORDERED_BY_IMPACT.size()))
    if score >= NOTE_ORDERED_BY_IMPACT.size():
        return NOTE_ORDERED_BY_IMPACT[NOTE_ORDERED_BY_IMPACT.size() - 1]
    elif score <= 0:
        return NOTE_ORDERED_BY_IMPACT[0]
    else:
        return NOTE_ORDERED_BY_IMPACT[score]
        
func show():
    for leaving_node in leaving_nodes:
        get_node(leaving_node).animation_player.play("leave")
    self.visible = true # TODO animate fade in
    
func hide():
    self.visible = false # TODO animate fade out
    for leaving_node in leaving_nodes:
        get_node(leaving_node).animation_player.play_backwards("leave")

func draggable_is_valid(draggable):
    return draggable is DropZone and draggable.selected_headline != null

func on_day_ended(world):
    for child in get_children():
        child.queue_free()
    currentSlot = -1
    time = 0
    has_clicked = false
    self.world = world
    doneScenarios = []
    show()

    
    