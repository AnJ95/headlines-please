const FormatUtils = preload("res://scripts/FormatUtils.gd")

var text
var params = {
    "bias" : randf() * 0.3 - 0.15 + 0.5,
    "satisfaction" : randf() * 0.3 - 0.15 + 0.5,
}
var drama = randf() * 0.3 - 0.15 + 0.5
var format_string

func _init(format_string):
    self.format_string = format_string

func prepare(world, scenario):
    text = FormatUtils.format(format_string, world.make_format_dic(scenario.countries))

func effect(world):
    pass