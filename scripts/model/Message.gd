enum { TWITTER, NOTE, LIVE }

var type
var format_string
var headlines

func _init(type, headlines, format_string):
    self.type = type
    self.headlines = headlines
    self.format_string = format_string

func get_text(world, countries):
    return format_string % countries

