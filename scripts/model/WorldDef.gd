extends Node


const Country = preload("res://scripts/model/Country.gd")
const Param = preload("res://scripts/model/Param.gd")


func get_countries():
    var countries = []
    countries.append(Country.new("Holsten", Vector2(-5,-54)))
    countries.append(Country.new("Reldan", Vector2(260,-48)))
    countries.append(Country.new("Lemuria", Vector2(64,140)))
    #countries.append(Country.new("Hesperdia", Vector2(290,130)))
    return countries

func get_scenarios():
    var scenarios = []
    #scenarios.append(load("res://scenarios/Scenario_ambassador.gd").new()) TODO
    scenarios.append(load("res://scenarios/Scenario_factory.gd").new())
    scenarios.append(load("res://scenarios/Scenario_ghettofire.gd").new())
    scenarios.append(load("res://scenarios/Scenario_hotel.gd").new())
    scenarios.append(load("res://scenarios/Scenario_practice_flight.gd").new())
    scenarios.append(load("res://scenarios/Scenario_small_online_salt.gd").new())
    scenarios.append(load("res://scenarios/Scenario_small_singer_dead.gd").new())
    scenarios.append(load("res://scenarios/Scenario_pedophile.gd").new())
    scenarios.append(load("res://scenarios/Scenario_pedophile_killed.gd").new())
    scenarios.append(load("res://scenarios/Scenario_pedophile_released.gd").new())
    scenarios.append(load("res://scenarios/Scenario_fish.gd").new())
    scenarios.append(load("res://scenarios/Scenario_refugees_in_albrahm.gd").new())
    scenarios.append(load("res://scenarios/Scenario_cancer_progress.gd").new())
    scenarios.append(load("res://scenarios/Scenario_philharmonia_planned.gd").new())
    scenarios.append(load("res://scenarios/Scenario_philharmonia_postponed.gd").new())
    scenarios.append(load("res://scenarios/Scenario_religion_clash_in_schools.gd").new())
    scenarios.append(load("res://scenarios/Scenario_ministry_pope.gd").new())
    scenarios.append(load("res://scenarios/Scenario_travel_warning.gd").new())
    scenarios.append(load("res://scenarios/Scenario_isf_host.gd").new())
    scenarios.append(load("res://scenarios/Scenario_isf_start.gd").new())
    scenarios.append(load("res://scenarios/Scenario_cultural_exchange.gd").new())
    scenarios.append(load("res://scenarios/Scenario_police_brutality.gd").new())
    scenarios.append(load("res://scenarios/Scenario_box_urinator.gd").new())
    scenarios.append(load("res://scenarios/Scenario_direct_democracy.gd").new())

    return scenarios

func get_params():
    var params = []
    params.append(Param.new("science", "Religious", "Sciencific"))
    params.append(Param.new("progress", "Conservative", "Progressive"))
    params.append(Param.new("democracy", "Authoritarian", "Democratic"))
    params.append(Param.new("tolerance", "Prejudiced", "Tolerant"))
    params.append(Param.new("culture", "Crudeness", "Cultural"))
    return params
