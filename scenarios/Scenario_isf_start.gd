extends "res://scripts/model/Scenario.gd"

func _init():
    name = "International Sports Festival Start"
    num_countries = 3
    init_headlines()
    init_messages()

func is_valid(world, countries):
    # if this is the follow-up scenario of "International Sports Festival Host"
    if not world.scenarioManager.did_scenario_happen("International Sports Festival Host", countries):
        return false
    return true

func init_headlines():
    h("The International Sports Festival in {country_1}", 0.3, {
        "culture" : 0.4
    }, [
        [1,2,0.1],
        [1,3,0.1],
        [2,3,0.1]
    ])
    h("{country_2} sky-rocketing on first day of ISF!", 0.5, {
        "culture" : 0.5
    }, [
        [1,2,0.05],
        [1,3,0.05]
    ])
    h("{country_2} investments in sports got them 2 gold medals already!", 0.5, {
        "progress" : 0.3,
        "culture" : 0.2
    }, [
        [1,2,0.07],
        [1,3,0.07]
    ])
    h("Are {country_2}s athletes doping?", 0.7, {
        "progress" : -0.15,
        "culture" : -0.3
    }, [
        [1,2,-0.17],
        [1,3,-0.17]
    ])
    h("Blood Test: Positive!", 0.8, {
        "science" : 0.3,
        "progress" : -0.3,
        "culture" : -0.3
    }, [
        [1,2,-0.3],
        [1,3,-0.3]
    ])



func init_messages():
    m(Message.TWEET, [], "brace yourself, #isf posts are coming", 0.04)
    m(Message.TWEET, [], "go #{country_2} #isf")
    m(Message.TWEET, [3], "{country_2}s athletes look super creepy")
    m(Message.TWEET, [3], "did they check {country_2}s athletes blood?")
    m(Message.TWEET, [], "tomorrow is table tennis day... boring!")


    m(Message.NOTE, [0], "The first day of the International Sports Festival is over.", 0)
    m(Message.NOTE, [0], "Todays ISF disciplines were the marathon and 100m sprint; tomorrows are table tennis and 400m swimming.")
    m(Message.NOTE, [1], "The International Sports Festivals debut was exciting, as {country_2} instantly dominated in both disciplines", 0.3)

    m(Message.PHAX, [2], "{country_2} has almost completly changed their athlete setup in comparison to last ISF")
    m(Message.PHAX, [3, 4], "Two athletes of {country_2} and one of {country_3} have been tested positive for doping!")
