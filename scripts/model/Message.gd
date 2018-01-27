enum { TWITTER, NOTE, LIVE }

var type
var format_string
var headlines

func _init(type, headlines, format_string):
    self.type = type
    self.headlines = headlines
    self.format_string = format_string

func get_text(world, countries):
    var country_names = []
    for c in countries:
        country_names.append(c.name)
    return format_string % country_names

