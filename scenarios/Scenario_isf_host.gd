extends "res://scripts/model/Scenario.gd"

func _init():
    name = "International Sports Festival Host"
    num_countries = 3
    init_headlines()
    init_messages()

func is_valid(world, countries):
    return true

func init_headlines():
    h("International Sports Festival in {country_1} celebrates 50 years of peace!", 0.3, {
        "democracy" : 0.45,
        "culture" : 0.4
    }, [
        [1,2,0.2],
        [2,3,0.2],
        [1,3,0.2]
    ])
    h("{country_1} elected host for this years International Sports Festival", 0.2, {
        "culture" : 0.2
    }, [
        [1,2,-0.1],
        [1,3,-0.1]
    ])
    h("{country_1} bribes International Sports Festivals committee!", 0.5, {
        "democracy" : 0.3,
        "culture" : -0.3
    }, [
        [1,2,-0.3],
        [1,3,-0.3]
    ])
    h("{country_2} invested a lot in sports clubs recently to win the ISF!", 0.3, {
        "progress" : 0.2,
        "culture" : 0.3
    }, [
        [1,2,-0.05],
        [1,3,-0.05]
    ])
    h("Strenghening its infrastucture for the ISF costs {country_1} billions!", 0.4, {
        "democracy" : 0.35,
        "culture" : -0.3
    })



func init_messages():
    m(Message.TWEET, [4], "theres much more important stuff to pay than sports #isf", 0.2)
    m(Message.TWEET, [2], "{country_1} elected host AGAIN?", 0.2)
    m(Message.TWEET, [], "Go {country_3}!", 0.2)

    m(Message.NOTE, [1], "Committee of the International Sports Festival decided {country_1} to be this years host")
    m(Message.NOTE, [0], "50ths International Sports Festival is closing in!")

    m(Message.PHAX, [2], "Rumours claim questionable deals were made for the hosts election", 0.4)
    m(Message.PHAX, [3, 4], "{country_2} raised its annual budget for sportive activies (sometime last year)", 0.33)
