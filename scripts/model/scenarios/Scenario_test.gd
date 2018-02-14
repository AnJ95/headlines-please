extends "res://scripts/model/Scenario.gd"

func _init():
    name = "Less fish"
    num_countries = 2
    init_headlines()
    init_messages()
    
    param_conditions = {
        1 : [
            ["progress", GREATER, 0.2]
        ],
        2 : [
            ["progress", LESS, -0.2]
        ]
    }
    
    relation_conditions = [
        [1, 2, GREATER, 0.2]
    ]

func init_headlines():
    pass

func init_messages():
    m(Message.NOTE, [], "{country_1} <3 {country_2}", 0)
