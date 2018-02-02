extends Node


const Country = preload("res://scripts/model/Country.gd")
const Param = preload("res://scripts/model/Param.gd")


func get_countries():
    var countries = []
    countries.append(Country.new("Holsten"))
    countries.append(Country.new("Reldan"))
    countries.append(Country.new("Lemuria"))
    countries.append(Country.new("Hesperdia"))
    return countries

func get_scenarios():
    var scenarios = []
    scenarios.append(load("res://scripts/model/scenarios/Scenario_factory.gd").new())
    scenarios.append(load("res://scripts/model/scenarios/Scenario_ghettofire.gd").new())
    scenarios.append(load("res://scripts/model/scenarios/Scenario_hotel.gd").new())
    scenarios.append(load("res://scripts/model/scenarios/Scenario_practice_flight.gd").new())
    scenarios.append(load("res://scripts/model/scenarios/Scenario_small_online_salt.gd").new())
    scenarios.append(load("res://scripts/model/scenarios/Scenario_small_singer_dead.gd").new())
    scenarios.append(load("res://scripts/model/scenarios/Scenario_pedophile.gd").new())
    scenarios.append(load("res://scripts/model/scenarios/Scenario_fish.gd").new())
    return scenarios
    
func get_params():
    var params = []
    params.append(Param.new("science", "Religion", "Science"))
    params.append(Param.new("progress", "Conservative", "Progressive"))
    params.append(Param.new("democracy", "Authoritarian", "Democracy"))
    params.append(Param.new("tolerance", "Prejudice", "Tolerance"))
    params.append(Param.new("", ""))
    params.append(Param.new("", ""))
    return params