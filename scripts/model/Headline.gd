const FormatUtils = preload("res://scripts/FormatUtils.gd")

var text
var params = {
    "economy" : randf() * 0.2 - 0.1 + 1,
    "satisfaction" : randf() * 0.2 - 0.1 + 1,
    "xenophobia" : randf() * 0.2 - 0.1 + 1
}
var format_string

func _init(format_string):
    self.format_string = format_string

func prepare(world, scenario):
    text = FormatUtils.format(format_string, world.make_format_dic(scenario.countries))

func effect(world):
    pass