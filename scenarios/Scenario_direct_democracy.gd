extends "res://scripts/model/Scenario.gd"

func _init():
    name = "Direct Democracy"
    num_countries = 3
    init_headlines()
    init_messages()


func init_headlines():
    h("{country_1} adding new political mechanism for voting", 0.4, {
      "democracy" : 0.35,
      "progress" : 0.4
    })
    h("Is {country_1} becoming a direct democracy?", 0.55, {
      "democracy" : 0.45
    })
    h("Is this the evolution of Democracy?", 0.7, {
      "democracy" : 0.6
    })
    h("{country_1} weakening its government by distributing power", 0.7, {
      "democracy" : -0.4,
    })
    h("{country_1} suddenly changing its constitution?", 0.7, {
      "democracy" : -0.4,
      "progress" : 0.4
    }, [
        [1, 2, -0.1]
        [1, 3, -0.1]
    ])



func init_messages():
    m(Message.TWEET, [], "yeah right the people know what they want")
    m(Message.TWEET, [], "how often will there be votes?")
    m(Message.TWEET, [], "#powertothepeople")

    m(Message.NOTE, [4], "{country_1} just changed its constitution", 0)
    m(Message.NOTE, [0], "The government of {country_1} is planning to make elections for certain situations", 0.4)
    m(Message.NOTE, [1, 2], "The changes in {country_1}s constitution make it a direct democracy by definition", 0.67)

    m(Message.PHAX, [3], "Politologist fear {country_1}s government could lose authority")
