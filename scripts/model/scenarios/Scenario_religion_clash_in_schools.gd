extends "res://scripts/model/Scenario.gd"

func _init():
    name = "Religion clash in Schools"
    num_countries = 1
    init_headlines()
    init_messages()
    param_conditions = {
        1 : [
            ["science", LESS, -0.4]
        ]
    }


func init_headlines():
    h("{country_1} children of other religions than Christianity are disadvantaged!", 0.48, {
        "science" : 0.3
    })
    h("Should schools educate Christian traditions and celebrate its holidays?", 0.34, {
        "science" : 0.2,
        "progress" : 0.3,
        "democracy" : 0.3,
        "tolerance": 0.5
    })
    h("Dispute about Christian symbols in schools renewed!", 0.4, {
        "progress" : 0.2,
        "democracy" : 0.5,
    })
    h("Foreign Parents complaining about crucifixes in schools!", 0.5, {
        "science" : -0.4,
        "tolerance": -0.4
    })
    h("Are they trying to take our religion away?!", 0.8, {
        "science" : -0.4,
        "tolerance": -0.7
    })


func init_messages():
    m(Message.TWEET, [], "#imagineallthepeople")
    m(Message.TWEET, [3], "how bad can a #crucifix over the board be?")
    m(Message.TWEET, [0, 1], "i just dont want my kid to be an outsider :(")

    m(Message.NOTE, [2, 3], "Several non-Christian parents have lodged a complaint about Christian symbols in schools")
    m(Message.NOTE, [1, 2], "Many schools have Christian traditions on christmas and easter as well as crucifixes")

    m(Message.PHAX, [0], "Studies show that children in {country_1} with non-Christian background are 14% more prone to bullying")
