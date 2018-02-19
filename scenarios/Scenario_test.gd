extends "res://scripts/model/Scenario.gd"

func _init():
    name = "test"
    num_countries = 2
    init_headlines()
    init_messages()


func is_valid(world, countries):
    if not countries[0].params["progress"] > 0.2:
        return false
    if not countries[1].params["progress"] < -0.2:
        return false
    
    var relation_value = world.relations.get_by_country_names(countries[0].name, countries[1].name)
    if not relation_value > 0.2:
        return false
    
    if not world.scenarioManager.did_scenario_happen("test", countries):
        return false
        
    return true


func init_headlines():
    pass


func init_messages():
    m(Message.NOTE, [], "{country_1} <3 {country_2}", 0)
