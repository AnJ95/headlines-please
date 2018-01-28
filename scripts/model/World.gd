extends Node

const Scenario = preload("res://scripts/model/Scenario.gd")
const Country = preload("res://scripts/model/Country.gd")
const Message = preload("res://scripts/model/Message.gd")

export var DAY_CYCLE_TIME = 45

var countries = []
var scenarios = []

var current_scenarios = {}

var game_running = true
var day = 0
var time = 0;
var last_time = -1;
var money = 100
var popularity = {}

signal day_started(world)
signal day_ended(world)
signal message_arrived(message)

func _init():
    countries.append(Country.new("Holsten"))
    countries.append(Country.new("Reldan"))
    countries.append(Country.new("Lemuria"))
    countries.append(Country.new("Hesperdia"))

    for c in countries:
        c.prepare(self)

    load_scenarios()


func _ready():
    next_day()

func _process(delta):

    get_node("Countdown").set_text(str(abs(round(DAY_CYCLE_TIME - time))))


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

var Scenario_Factory = load("res://scripts/model/scenarios/Scenario_factory.gd")
var Scenario_Ghettofire = load("res://scripts/model/scenarios/Scenario_ghettofire.gd")
var Scenario_Hotel = load("res://scripts/model/scenarios/Scenario_hotel.gd")
var Scenario_Practice_Flight = load("res://scripts/model/scenarios/Scenario_practice_flight.gd")
var Scenario_small_1 = load("res://scripts/model/scenarios/Scenario_practice_flight.gd")
var Scenario_small_2 = load("res://scripts/model/scenarios/Scenario_practice_flight.gd")
#var Scenario_Ambassador = load("res://scripts/model/scenarios/Scenario_Ambassador.gd")

func load_scenarios():
    #scenarios.append(Scenario_Ambassador.new())
    scenarios.append(Scenario_Factory.new())
    scenarios.append(Scenario_Ghettofire.new())
    scenarios.append(Scenario_Hotel.new())
    scenarios.append(Scenario_Practice_Flight.new())
    scenarios.append(Scenario_small_1.new())
    scenarios.append(Scenario_small_2.new())
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
    print("next_day")
    current_scenarios = {}
    for i in range(2):
        var next_scenario = get_scenario()
        current_scenarios[next_scenario.name] = next_scenario

    get_node("Draggables/Map").update(countries)
    emit_signal("day_started", self)

    day += 1
    time = 0
    last_time = -1
    game_running = true

    emit_signal("day_started", self)


func end_day():
    print("end_day")
    game_running = false
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

const MAX_READERS_CHANGE = 0.08
const MAX_PARAM_CHANGE = 0.08

func broadcast_headline(headline):

    print("adding headline: " + params_to_string(headline.params))

    var readerChanges = {}
    var totalReaders = get_total_readers()

    for country in countries:
        print("country before: " + params_to_string(country.params) + " readers: " + str(country.readers))
        var sum_dist = 0 # sth between 0 (best case) and params_num (worst case)
        for p in headline.params:
            # assert: country params in (0,1]
            #         headline params in (0,1)
            var dist = headline.params[p]- country.params[p]
            country.params[p] += dist * MAX_PARAM_CHANGE * country.readers
            sum_dist += abs(dist)
        var norm_dist = sum_dist / country.params.size()

        readerChanges[country.name] = (0.5 - norm_dist) * 2 * MAX_READERS_CHANGE * headline.drama
        country.readers += readerChanges[country.name]
        print("country after: " + params_to_string(country.params) + " readers: " + str(country.readers))

    return get_total_readers() - totalReaders


func get_total_readers():
    var total = 0
    for country in countries:
        total += country.readers * country.inhabitants
    return total

func params_to_string(p):
    return str(p)

func cap_values():
    for c in countries:
        for p in c.params:
            c.params[p] = cap(c.params[p])
        c.readers = cap(c.readers)
    pass

func cap(val):
    if (val > 1):
        return 1
    if (val < 0):
        return 0
    return val

func fisher_yates(array):
    for i in range(0, array.size()-2):
        var j = i + randi() % (array.size() - i)
        var tmp = array[j]
        array[j] = array[i]
        array[i] = tmp


func _on_Main_day_started( world ):
    pass # replace with function body
