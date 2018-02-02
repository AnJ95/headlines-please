const FormatUtils = preload("res://scripts/FormatUtils.gd")

var scenario_name
var text
var params = {}
var drama = 0
var format_string

func _init(format_string, drama, params):
    self.format_string = format_string

    self.params = params
    self.drama = drama

func prepare(world, scenario):
    scenario_name = scenario.name
    text = FormatUtils.format(format_string, world.make_format_dic(scenario.countries))

func effect(world):
    pass
