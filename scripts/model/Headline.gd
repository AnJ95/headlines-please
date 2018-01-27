var text = ""

var format_string

func _init(format_string):
    self.format_string = format_string

func get_text(world, countries):
    return format_string % countries

func effect(world):
    pass