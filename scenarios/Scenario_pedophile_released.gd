extends "res://scripts/model/Scenario.gd"

func _init():
    name = "Pedophile Bishop Released"
    num_countries = 3
    init_headlines()
    init_messages()

func is_valid(world, countries):
    # if this is the follow-up scenario of "Pedophile Bishop"
    # in case the country got more religious
    # Also check for the alternative scenario not to have happened
    if not countries[0].params["science"] > -0.6:
        return false
    if not world.scenarioManager.did_scenario_happen("Pedophile Bishop", countries):
        return false
    if world.scenarioManager.did_scenario_happen("Pedophile Bishop Killed", countries):
        return false
    return true


func init_headlines():
    h("Bishop Ainsworth was released early for good behavior!", 0.4, {
        "science" : -0.2
    })
    h("Serial Pedophile Bishop back on free feet?", 0.4, {
        "science" : -0.4
    })
    h("{country_1} releases crazy Pedophile Bishop!", 0.6, {
        "science" : 0.6
    }, [
        [1,2,-0.2],
        [1,3,-0.2]
    ])
    h("Religious authorities in {country_1} issued release of Bishop Ainsworth!", 0.6, {
        "democracy" : 0.35,
        "science" : -0.2
    })
    h("The story about a country in religious hands", 0.7, {
        "science" : -0.5,
        "democracy" : 0.28
    })




func init_messages():
    m(Message.TWEET, [2], "wtf why?? he was supposed to be locked up for 15 years!", 0.1)
    m(Message.TWEET, [0], "I knew Bishop Ainsworth. he was a good man and helped me in moments i needed help most #freeainsworth", 0.2)
    m(Message.TWEET, [], "#freeainsworth", 0.34)
    m(Message.TWEET, [2], "I dont want this sicko to be free", 0.46)
    m(Message.TWEET, [4], "{country_1} this is a joke, u are ruled by pedophiles", 0.6)
    m(Message.TWEET, [2], "release the pedophile religious freak - what could possibly go wrong?", 0.85)

    m(Message.NOTE, [0], "According to prison reports Bishop Ainsworth is a \"likeable idol always willing to help others\"")
    m(Message.NOTE, [1], "The pedophile Bishop Ainsworth was released early!")
    m(Message.NOTE, [3], "Rumors say the Bishop got help from religious institutions and organisations")

    m(Message.PHAX, [4], "Eye witnesses claim to have seen multiple religious people visiting the prison and the local court house")
