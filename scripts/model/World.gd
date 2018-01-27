extends Node

const Scenario = preload("res://scripts/model/Scenario.gd")
const Country = preload("res://scripts/model/Country.gd")
const Message = preload("res://scripts/model/Message.gd")

var countries = []
var scenarios = []

var current_scenarios = {}

var day = 0

signal dawn_of_a_new_day(world)

func _init():
    countries.append(Country.new("testonia"))
    countries.append(Country.new("debugtania"))
    countries.append(Country.new("try catchistan"))
    countries.append(Country.new("trialidat and errorgo"))

    for c in countries:
        print(c.name)
        c.prepare(self)

    init_scenarios()

    for s in scenarios:
        print(s.name)
        
    
    #TODO first day
    next_day()


func init_scenarios():
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
    day += 1
    current_scenarios = {}
    # TODO do 3 times ?
    var next_scenario = get_scenario()
    current_scenarios[next_scenario.name] = next_scenario
    print(current_scenarios)
    
    emit_signal("dawn_of_a_new_day", self);
    
    
    
    
    
    
    
    


func get_scenario():
    return scenarios[0]
    
    
    
    
    
    
    
    
    
    for s in scenarios:
        var num_countries = s.num_countries
        if s.get_propability(self):
           pass


func fisher_yates(array):
    for i in range(0, array.size()-2):
        var j = i + randi() % (array.size() - i)
        var tmp = array[j]
        array[j] = array[i]
        array[i] = tmp
