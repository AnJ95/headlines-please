extends Control

onready var lblPopValue = $lblPopValue
onready var lblTitle = $lblTitle
onready var params = $params

export var progress_bar_space = 20

var ProgressBar = preload("res://scenes/ProgressBar.tscn")

var param_elems = {}

func init(country, params):
    lblTitle.set_text(str(country.name))
    
    rect_position = country.country_info_pos
    
    var cur_y = 0
    for param in params:
        var node = ProgressBar.instance()
        node.rect_position = Vector2(0, cur_y)
        self.params.add_child(node)
        node.init(param)
        cur_y += progress_bar_space
        param_elems[param.name] = node
    
    update(country)

func update(country):
    lblPopValue.set_text(str(round(country.inhabitants)) + "M")
    
    for param in param_elems:
        param_elems[param].update(country.params[param] / 2 + 0.5)
        
    #for progressBar in params:
         #progressBar.
    #get_node("lblReaders").set_text(str(round(country.inhabitants * country.readers)) + "M")
    #get_node("Economy").update(country.params["economy"])
    #get_node("Satisfaction").update(country.params["satisfaction"])
    #get_node("Bias").update(country.params["bias"])
    
    