extends "res://scripts/model/Scenario.gd"

func _init():
    name = "Philharmonia postponed"
    num_countries = 1
    init_headlines()
    init_messages()
    scenario_conditions = [
        "Philharmonia planned"
    ]


func init_headlines():
    h("Grand Philharmonia delayed!", 0.4, {
        "culture" : -0.2,
        "progress" : -0.2
    })
    h("\"The plans and the progress of the Grand Philharmonia are disastrous!\"", 0.6, {
        "culture" : -0.2,
        "progress" : -0.2,
        "democracy" : 0.1
    })
    h("{country_1}s planned expenses for the Grand Philharmonia doubled to 866 million Dollar!", 0.7, {
        "culture" : -0.1,
        "progress" : -0.3,
        "democracy" : 0.13
    })
    h("\"Grand Budget Philharmonia\" is most expensive investment in {country_1} this year!", 0.7, {
        "culture" : -0.2,
        "progress" : -0.35,
    })


func init_messages():
    m(Message.NOTE, [0], "The Grand Philharmonias completion time will be later than calculated")
    m(Message.NOTE, [1], "The construction project Grand Philharmonia in {country_1} has problems in its plans and will be more costly than diagnosed.", 0.05)
    m(Message.PHAX, [1, 2], "The Grand Philharmonias price has risen from its first estimate 450 to 866mio$")

    m(Message.TWEET, [1], "#grandphilharmonia is a good idea but {country_1} #canthandleshit")
    m(Message.TWEET, [3], "stop #grandbudgetphilharmonia #grandphilharmonia")
