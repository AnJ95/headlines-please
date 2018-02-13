const FormatUtils = preload("res://scripts/FormatUtils.gd")

var scenario
var text
var params = {}
var drama = 0
var relations
var format_string

func _init(format_string, drama, params, relations):
    self.format_string = format_string
    self.drama = drama
    self.params = params
    self.relations = relations

func prepare(world, scenario):
    self.scenario = scenario
    text = FormatUtils.format(format_string, world.make_format_dic(scenario.countries))

func effect(world):
    pass
