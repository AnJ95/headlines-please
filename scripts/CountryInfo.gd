extends Control

onready var lblPopValue = $lblPopValue
onready var lblTitle = $lblTitle
onready var prgReaders = $prgReaders
onready var prgHappy = $prgHappy
onready var params = $params

export var progress_bar_space = 18

var ParamBar = preload("res://scenes/ParamBar.tscn")

var param_elems = {}

func init(country, params):
    lblTitle.set_text(str(country.name))
    
    rect_position = country.country_info_pos
    
    var cur_y = 0
    for param in params:
        var node = ParamBar.instance()
        node.rect_position = Vector2(0, cur_y)
        self.params.add_child(node)
        node.init(param)
        cur_y += progress_bar_space
        param_elems[param.name] = node
    
    update(country)

func update(country):
    lblPopValue.set_text(str(round(country.inhabitants)) + "M")
    prgReaders.update(country.readers)
    prgHappy.update(country.happyness)
    for param in param_elems:
        param_elems[param].update(country.params[param])
    
    