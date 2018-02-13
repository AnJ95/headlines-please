extends Node

const Scenario = preload("res://scripts/model/Scenario.gd")
const Country = preload("res://scripts/model/Country.gd")
const Message = preload("res://scripts/model/Message.gd")
const CountryRelations = preload("res://scripts/model/CountryRelations.gd")

const COSTS_PER_DAY = 35
const MONEY_PER_READER = 1

onready var world_def = $world_def

export var DAY_CYCLE_TIME = 45

var params = []
var countries = []
var scenarios = []
var relations

var current_scenarios = {}

var game_running = true
var day = 0
var time = 0;
var last_time = -1;
var money = 100
var popularity = {}

signal game_started(world)
signal day_started(world)
signal day_ended(world)
signal message_arrived(message)

func _init():
    randomize()

func _ready():
    countries = world_def.get_countries()
    for c in countries:
        c.prepare(self)
        
    scenarios = world_def.get_scenarios()
    
    params = world_def.get_params()
    
    relations = CountryRelations.new(countries)
    
    emit_signal("game_started", self)
    
    next_day()

func _process(delta):

    get_node("TweetrContainer/Countdown").set_text(str(abs(round(DAY_CYCLE_TIME - time))))


    if not game_running:
        return

    for s in current_scenarios:
        for m in current_scenarios[s].messages:
            if m.arrival_time * DAY_CYCLE_TIME > last_time && m.arrival_time * DAY_CYCLE_TIME <= time:
                emit_signal("message_arrived", m);

    last_time = time
    time += delta
    if time >= DAY_CYCLE_TIME:
        end_day()

# currently unused
func load_scenarios():
    return
    #TODO geht das so überhaubt?
    var dir = Directory.new()
    if dir.open("res://scripts/model/scenarios") == OK:
        dir.list_dir_begin(true)
        var file_name = dir.get_next()
        while (file_name != ""):
            if dir.current_is_dir():
                continue
            var LoadedScenario = load("res://scripts/model/scenarios/" + file_name)
            scenarios.append(LoadedScenario.new())
            file_name = dir.get_next()
        dir.list_dir_end ( )
    else:
        print("An error occurred when trying to access the path.")


func next_day():
    current_scenarios = {}
    while current_scenarios.size() < 2:
        var next_scenario = get_scenario()
        if !current_scenarios.has(next_scenario.name):
            current_scenarios[next_scenario.name] = next_scenario

    day += 1
    time = 0
    last_time = -1
    game_running = true

    get_node("Draggables/Map").update(self)
    
    emit_signal("day_started", self)


func end_day():
    print("end_day")
    game_running = false

    money += get_current_bilances()
    get_node("TweetrContainer/Money").set_text(str(round(money)) + "$")

    emit_signal("day_ended", self)


func get_scenario():
    var s_num = randi() % scenarios.size()
    var s = scenarios[s_num]
    var s_countries = []
    for i in range(s.num_countries):
        s_countries.append(countries[i])
    s.prepare(self, s_countries)
    return s

    for s in scenarios:
        var num_countries = s.num_countries
        if s.get_propability(self):
           pass


func make_format_dic(countries):
    var format_dic = {}
    for c in range(countries.size()):
       format_dic["country_" + str(c + 1)] = countries[c].name
    return format_dic

func broadcast_headline(headline):

    print("adding headline: " + str(headline.params))
    print("drama : " + str(headline.drama))

    var totalReaders = get_total_readers()
    for country in countries:
        country.broadcast_headline(headline)
    return get_total_readers() - totalReaders

func get_total_population():
    var total = 0
    for country in countries:
        total += country.inhabitants
    return total
    
func get_total_readers():
    var total = 0
    for country in countries:
        total += country.readers * country.inhabitants
    return total
    
func get_current_bilances():
    return get_total_readers() * MONEY_PER_READER - COSTS_PER_DAY
    
func get_country(country_name):
    for country in countries:
        if country.name == country_name:
            return country
    return null

func fisher_yates(array):
    for i in range(0, array.size()-2):
        var j = i + randi() % (array.size() - i)
        var tmp = array[j]
        array[j] = array[i]
        array[i] = tmp


func _on_Main_day_started( world ):
    pass # replace with function body
