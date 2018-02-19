extends "res://scripts/model/Scenario.gd"

func _init():
    name = "Ministry of the Pope"
    num_countries = 1
    init_headlines()
    init_messages()
    param_conditions = {
        1 : [
            ["science", LESS, -0.5],
            ["democracy", LESS, -0.3]
        ]
    }


func init_headlines():
    h("{country_1} has introduced a religious Ministry", 0.3, {
        "science" : -0.3,
        "progress": 0.2
    })
    h("{country_1} founds Ministry of the Pope!", 0.45, {
        "science" : -0.2,
        "democracy" : -0.2
    })
    h("Is {country_1} becoming a Theocracy?", 0.58, {
        "science" : 0.2,
        "progress" : -0.3,
        "democracy" : 0.4
    })
    h("Is the Pope secretly ruling {country_1}?", 0.6, {
        "science" : 0.6,
        "tolerance" : -0.3,
        "democracy" : 0.3,
    })
    h("{country_1}s government is becoming Christian - and they love it!", 0.6, {
        "science" : -0.6,
        "democracy" : 0.4
    })



func init_messages():
    m(Message.TWEET, [4], "praise the lord for he is #glorious")
    m(Message.TWEET, [2], "#middleages #ministryofthepope", 0.3)
    m(Message.NOTE, [0, 1], "{country_1}s government founded a religious Ministry of the Pope")#
    m(Message.NOTE, [0], "The Ministry of the Popes was installed to \"handle all godly affairs\".")
    m(Message.NOTE, [2], "It is unclear how much influce the new ministry in {country_1} will have.")
    m(Message.PHAX, [4], "Study on {country_1}ians shows 73% share of religious devotees")
    m(Message.PHAX, [3], "Some bishops from the Vatican were send to the Ministry of the Pope")
