extends "res://scripts/model/Scenario.gd"

func _init():
    name = "Pedophile Bishop Killed"
    num_countries = 1
    init_headlines()
    init_messages()
    
func is_valid(world, countries):
    if not countries[0].params["science"] > 0.5:
        return false
    if not world.scenarioManager.did_scenario_happen("Pedophile Bishop", countries):
        return false
    return true


func init_headlines():
    h("Pedophile Bishop killed in prison!", 0.75, {
        "science" : 0.4
    })
    h("Bishop killed by inmates in his cell!", 0.5, {
        "science" : 0.25,
        "tolerance" : -0.25
    })
    h("Prison not ensuring inmates safety!", 0.4, {
        "democracy" : -0.3,
        "progress" : 0.2
    })
    h("Pedophiles deserved punishment!", 0.6, {
        "democracy" : 0.3,
        "progress" : -0.3,
        "tolerance" : -0.4
    })
    h("Ex-Bishop receiving heavenly punishment in prison after abusing children!", 0.66, {
        "science" : -0.4,
        "progress" : -0.4
    })


func init_messages():
    m(Message.TWEET, [3], "#justiceisserved")
    m(Message.TWEET, [4], "i hope they did the same to him as he did to all the children")
    
    m(Message.NOTE, [2], "Yesterday night, there was a murder in {country_1}s prison", 0)
    m(Message.NOTE, [0], "The Bishop being in prison for pedophilia was killed")

    m(Message.PHAX, [1], "The Bishop was apparently strangled by an inmate of his cell")
