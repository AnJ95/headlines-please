extends "res://scripts/model/Scenario.gd"

func _init():
    name = "Police brutality"
    num_countries = 1
    init_headlines()
    init_messages()

func is_valid(world, countries):
    return countries[0].params["democracy"] < -0.4 and countries[0].params["culture"] < -0.4


func init_headlines():
    h("Shop owner brutaly beat up by the Police of {country_1}", 0.6, {
        "democracy" : 0.52,
        "progress" : 0.41
    })
    h("Another tax fraud caught - now even bookshop owners?!", 0.5, {
        "progress" : -0.64,
        "culture" : -0.36
    })
    h("Criminal bookshop owner arrested!", 0.35, {
        "democracy" : -0.45,
        "culture" : -0.21
    })
    h("Bookshop owner in {country_1} caught for spreading inappropriate rumours!", 0.5, {
        "democracy" : -0.68,
        "progress" : -0.42
    })
    h("{country_1} forces regional libraries to close!", 0.5, {
        "culture" : 0.5,
        "democracy" : 0.4
    })


func init_messages():
    m(Message.TWEET, [], "#policebrutality")
    m(Message.TWEET, [], "book shop owner is a criminal- so just arrest him", 0.2)
    m(Message.TWEET, [4], "My favorite library closed last week too :(", 0.17)

    m(Message.NOTE, [2], "The owner of a bookshop in {country_1} was arrested yesterday night", 0.05)
    m(Message.NOTE, [0], "There was a violent police operation in {country_1} in a bookshop.", 0.3)
    m(Message.NOTE, [1], "The librarian is said to have committed tax fraud", 0.12)

    m(Message.PHAX, [3], "Police stated the bookshop owner \"is a terrorist spreading inappropriate rumours\"", 0.25)
    m(Message.PHAX, [4], "Statistics show actual decline in bookshops and libraries in {country_1}", 0.39)
