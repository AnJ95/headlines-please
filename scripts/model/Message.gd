const FormatUtils = preload("res://scripts/FormatUtils.gd")

enum { TWITTER, NOTE, LIVE }

var type
var format_string
var headlines
var text
var scenario

func _init(type, headlines, format_string):
    self.type = type
    self.headlines = headlines
    self.format_string = format_string

func prepare(world, scenario):
    self.scenario = scenario
    text = FormatUtils.format(format_string, world.make_format_dic(scenario.countries))

func get_headlines():
    var headlines = []
    for h in self.headlines:
        headlines.append(scenario.headlines[h])
    return headlines