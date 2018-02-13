extends Node

const Scenario = preload("res://scripts/model/Scenario.gd")
const Country = preload("res://scripts/model/Country.gd")
const Message = preload("res://scripts/model/Message.gd")
const CountryRelations = preload("res://scripts/model/CountryRelations.gd")
const ScenarioManager = preload("res://scripts/model/ScenarioManager.gd")

const COSTS_PER_DAY = 35
const MONEY_PER_READER = 1
const MAX_RELATION_CHANGE = 0.4

onready var world_def = $world_def

export var DAY_CYCLE_TIME = 45

var params = []
var countries = []
var scenarioManager = []
var relations

var game_running = true
var day = 0
var time = 0;
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
        
    scenarioManager = ScenarioManager.new(countries, world_def.get_scenarios())
    
    params = world_def.get_params()
    
    relations = CountryRelations.new(countries)
    
    emit_signal("game_started", self)
    
    next_day()

func _process(delta):

    get_node("TweetrContainer/Countdown").set_text(str(abs(round(DAY_CYCLE_TIME - time))))

    if not game_running:
        return
    
    scenarioManager.check_for_new_scenarios(self, time / DAY_CYCLE_TIME)

    time += delta
    if time >= DAY_CYCLE_TIME:
        end_day()


func next_day():
    scenarioManager.next_day()

    day += 1
    time = 0
    game_running = true

    get_node("Draggables/Map").update(self)
    
    emit_signal("day_started", self)


func end_day():
    print("end_day")
    game_running = false

    money += get_current_bilances()
    get_node("TweetrContainer/Money").set_text(str(round(money)) + "$")

    emit_signal("day_ended", self)

func broadcast_headline(headline):    
    # First evaluate relations between countries
    for rel in headline.relations:
        var c_a = headline.scenario.countries[rel[0] - 1]
        var c_b = headline.scenario.countries[rel[1] - 1]
        relations.change_by_country_names(c_a.name, c_b.name, rel[2])
    
    # Then evaluate for each country itself
    for country in countries:
        country.broadcast_headline(headline)

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

func _on_Main_day_started( world ):
    pass # replace with function body
