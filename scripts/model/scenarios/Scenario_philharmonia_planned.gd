extends "res://scripts/model/Scenario.gd"

func _init():
    name = "Philharmonia planned"
    num_countries = 1
    init_headlines()
    init_messages()
    param_conditions = {
        1 : [
            ["culture", GREATER, 0.4]
        ]
    }


func init_headlines():
    h("{country_1} starting ambitious building project \"Grand Philharmonia\"", 0.3, {
        "culture" : 0.2
    })
    h("State of {country_1} wasting money by building oversized theatre!", 0.6, {
        "culture" : -0.6,
        "democracy" : 0.2
    })
    h("{country_1} investing in culture by building the \"Grand Philharmonia\"", 0.3, {
        "culture" : 0.4,
    })
    h("President of {country_1}: The \"Grand Philharmonia\" is a very important project for the people of {country_1}", 0.4, {
        "culture" : 0.5,
        "democracy" : -0.2
    })


func init_messages():
    m(Message.NOTE, [0, 2], "{country_1} planning to build costly theatre, the \"Grad Philharmonia\"")
    m(Message.NOTE, [1], "{country_1} has commissioned several top-architects with designing the Grand Philharmonia")
    m(Message.PHAX, [3], "The president of {country_1} just held a press conference, stating the Grand Philharmonia is important for the people", 0.2)
    m(Message.TWEET, [1], "Great, who even needs new school equipment? Just throw out money for some theatre :(")
    m(Message.TWEET, [1], "very important for the people my ass", 0.3)
    
