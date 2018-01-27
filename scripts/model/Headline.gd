const FormatUtils = preload("res://scripts/FormatUtils.gd")

var text

var format_string

func _init(format_string):
    self.format_string = format_string

func prepare(world, countries):
    text = FormatUtils(format_string, world.make_format_dic(countries))

func effect(world):
    pass