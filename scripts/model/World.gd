extends Node

const Scenario = preload("res://scripts/model/Scenario.gd")
const Country = preload("res://scripts/model/Country.gd")
const Message = preload("res://scripts/model/Message.gd")

const DAY_CYCLE_TIME = 45

var countries = []
var scenarios = []

var current_scenarios = {}

var day = 0
var time = DAY_CYCLE_TIME;
var last_time = -1;
var money = 100
var popularity = {}

signal day_started(world)
signal day_ended(world)
signal message_arrived(message)

func _init():
    countries.append(Country.new("Testonia"))
    countries.append(Country.new("Debugtania"))
    countries.append(Country.new("Try Catchistan"))
    countries.append(Country.new("Trialidat and Errorgo"))

    for c in countries:
        c.prepare(self)

    load_scenarios()


func _ready():
    next_day()

func _process(delta):
    for s in current_scenarios:
        for m in current_scenarios[s].messages:
            if m.arrival_time * DAY_CYCLE_TIME > last_time && m.arrival_time * DAY_CYCLE_TIME <= time:
                emit_signal("message_arrived", m);

    last_time = time
    time += delta
    print(time)
    if time >= DAY_CYCLE_TIME:
       end_day()
       # next_day()


func load_scenarios():
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
    for i in range(1):
      var next_scenario = get_scenario()
      current_scenarios[next_scenario.name] = next_scenario

    emit_signal("day_started", self)

    day += 1
    time = 0
    last_time = -1


func end_day():
    emit_signal("day_ended", self)




func get_scenario():
    var s = scenarios[0]
    s.prepare(self, [countries[0], countries[1]])
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





func fisher_yates(array):
    for i in range(0, array.size()-2):
        var j = i + randi() % (array.size() - i)
        var tmp = array[j]
        array[j] = array[i]
        array[i] = tmp
