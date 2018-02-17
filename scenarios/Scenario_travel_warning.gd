extends "res://scripts/model/Scenario.gd"

func _init():
    name = "Travel Warning"
    num_countries = 2
    init_headlines()
    init_messages()


func is_valid(world, countries):
    var relation_value = world.relations.get_by_country_names(countries[0].name, countries[1].name)
    if not relation_value < - 0.5:
        return false
        
    return true


func init_headlines():
    h("{country_1} deems {country_2} unsafe", 0.55, {
    })
    h("{country_1} issues a travel advisory for {country_2}", 0.4, {
    })
    h("{country_1} provokes {country_2} with a travel warning", 0.6, {
    })


func init_messages():
    m(Message.TWEET, [], "I was just booking a holiday trip to {country_2}. Guess I will wait")
    m(Message.TWEET, [], "My husband is currently in {country_2}. I am worried")
    m(Message.TWEET, [], "Why would {country_1} be unsave?")
    m(Message.TWEET, [], "Why would {country_1} be unsave?")
    m(Message.TWEET, [], "I never trusted those bastards in {country_2}")
    m(Message.TWEET, [], "The travel warning is complete bullshit. WTF is {country_1} thinking")
    m(Message.TWEET, [2], "To me this look like a the idiots of {country_1} are provoking a war")
    m(Message.TWEET, [], "Muslim ban now!!")

    m(Message.NOTE, [0,1,2], "The Department of State of {country_1} issues a travel warning for {country_2}")
    m(Message.NOTE, [2], "Rumors are that {country_1}s travel warning is ")

    #m(Message.PHAX, [], "The head of {country_1}s state department told the press that the travel waring", 0.35)
