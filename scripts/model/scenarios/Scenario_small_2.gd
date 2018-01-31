extends "res://scripts/model/Scenario.gd"

func _init():
    name = "Ambassador died"
    num_countries = 2
    init_headlines()
    init_messages()

func get_propability(world, countries):
    return randf() < 0.05

#TODO set an effect for each Headline

func init_headlines():
    h("Singer McDole dies in car crash due to drunkenness.", 0.50,0.50,0.21)
    h("Singer McDole passed away in tragic accident.", 0.50,0.50,0.14)
    h("Beloved Singer McDole died in tragic accident.", 0.50,0.50,0.19)


func init_messages():
    m(Message.TWEET, [0,1], "Bobby McDole was known to be a frequent whisky drinker.", 0.85)
    m(Message.TWEET, [1,2], "God bless McDoles soul!!! #restinpeace", 0.25)
    m(Message.NOTE, [0,1], "Famous Musican Bobby McDole dies in car crash.")
