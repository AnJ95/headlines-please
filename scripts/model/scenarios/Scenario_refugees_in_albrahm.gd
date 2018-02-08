extends "res://scripts/model/Scenario.gd"

func _init():
    name = "Refugees in Albrahm"
    num_countries = 1
    init_headlines()
    init_messages()

func get_propability(world, countries):
    return randf() < 0.05

#TODO set an effect for each Headline

func init_headlines():
    h("{country_1}s immigrated population suffers poverty!", 0.3, {
        "tolerance" : 0.3
    })
    h("Refugees in Albrahm, {country_1} need help now!", 0.45, {
        "tolerance" : 0.6
    })
    h("Is Albrahm in {country_1} turning into a ghetto after refugee wave? ", 0.3, {
        "tolerance" : -0.1,
        "progress" : -0.2
    })
    h("Immigrants in Albrahm, {country_1} are not working and cost Millions! ", 0.5, {
        "tolerance" : -0.5,
        "progress" : -0.3
    })
    h("60% of immigrants in {country_1} are not working!", 0.6, {
        "tolerance" : -0.2
    })
    h("{country_1} is overwhelmed after refugee wave and must improve its immigration processes!", 0.2, {
        "tolerance" : 0.2,
        "progess": 0.3
    })


func init_messages():
    m(Message.NOTE, [0, 2, 3], "Many refugees in Albrahm, {country_1} earn not enough money for their daily live")
    m(Message.NOTE, [2], "{country_1} has many refugees in Albrahm and its state is worsening.")
    m(Message.PHAX, [3, 4, 5], "45% of refugees in Albrahm are waiting for legal permission to work in {country_1}, 15% cannot find a job.", 0.3)
    m(Message.TWEET, [0, 1], "The refugees in Albrahm look so sad and poor... help them!!", 0.4)
    
