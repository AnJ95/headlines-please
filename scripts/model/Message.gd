const FormatUtils = preload("res://scripts/FormatUtils.gd")

enum { TWITTER, NOTE, LIVE }

var type
var format_string
var headlines
var text

func _init(type, headlines, format_string):
    self.type = type
    self.headlines = headlines
    self.format_string = format_string

func prepare(world, countries):
    text = FormatUtils(format_string, world.make_format_dic(countries))

