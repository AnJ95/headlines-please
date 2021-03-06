extends "res://scripts/model/Scenario.gd"

func _init():
    name = "Less fish"
    num_countries = 3
    init_headlines()
    init_messages()

func is_valid(world, countries):
    if not countries[0].params["progress"] < -0.2:
        return false
        
    return true


func init_headlines():
    h("We are out of fish!", 0.5, {
        "science" : -0.1
    })
    h("Studies show decline in fish populations", 0.1, {
        "science" : 0.3
    })
    h("{country_1}s lacking reglementations lead to extinction of multiple fish species", 0.3, {
        "science" : 0.15,
        "democracy" : 0.1
    }, [
        [1,2,-0.2],
        [1,3,-0.2]
    ])
    h("{country_1}ian scientist on declining fish populations: \"It's a recurring natural phenomenon\"", 0.3, {
        "science" : -0.4,
        "progress" : -0.3
    }, [
        [1,2,-0.1],
        [1,3,-0.1]
    ])


func init_messages():
    m(Message.TWEET, [], "#savethefish")
    m(Message.TWEET, [], "#howmuchisthefish")
    m(Message.TWEET, [], "It's called weather")
    m(Message.TWEET, [3], "The fluctuation in the fish population is a natural phenomenon #trustmeimascientist", 0.2)

    m(Message.NOTE, [2], "Scientific studies show rise in pollution of {country_1} results in the death of fish")
    m(Message.NOTE, [0, 1], "Multiple fish species have gone extinct due to pollution of the sea")
    m(Message.NOTE, [0, 1], "4 salmon sub species have died out after the effects of pollution")
