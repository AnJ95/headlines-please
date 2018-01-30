const FormatUtils = preload("res://scripts/FormatUtils.gd")

enum { TWEET, NOTE, PHAX }

const MAX_RANDOM_ARRIVAL_TIME = 0.3
var type
var format_string
var headlines
var text
var scenario
var arrival_time

func _init(type, headlines, format_string, arrival_time = -1):
    self.type = type
    self.headlines = headlines
    self.format_string = format_string
    if arrival_time == -1:
        self.arrival_time = randf() * MAX_RANDOM_ARRIVAL_TIME
    else:
        self.arrival_time = arrival_time

func prepare(world, scenario):
    self.scenario = scenario
    text = FormatUtils.format(format_string, world.make_format_dic(scenario.countries))

func get_headlines():
    var headlines = []
    for h in self.headlines:
        headlines.append(scenario.headlines[h])
    return headlines
