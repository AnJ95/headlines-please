const FormatUtils = preload("res://scripts/FormatUtils.gd")

enum { TWITTER, NOTE, TELEGRAPH }

var type
var format_string
var headlines
var text
var scenario
var arrival_time

func _init(type, headlines, format_string, arrival_time = 0):
    self.type = type
    self.headlines = headlines
    self.format_string = format_string
    self.arrival_time = arrival_time

func prepare(world, scenario):
    self.scenario = scenario
    text = FormatUtils.format(format_string, world.make_format_dic(scenario.countries))

func get_headlines():
    var headlines = []
    for h in self.headlines:
        headlines.append(scenario.headlines[h])
    return headlines
