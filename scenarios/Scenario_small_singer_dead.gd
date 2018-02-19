extends "res://scripts/model/Scenario.gd"

func _init():
    name = "Singer dead"
    num_countries = 1
    init_headlines()
    init_messages()


func init_headlines():
    h("Singer McDole dies in car crash due to drunkenness.", 0.21, {
      "culture" : 0.2,
      "progress" : -0.1
    })
    h("Singer McDole passed away.", 0.14, {
      "culture" : -0.2,
      "progress" : 0
    })
    h("Beloved Singer McDole died in tragic accident.", 0.19, {
      "culture" : 0.38,
      "progress" : 0
    })


func init_messages():
    m(Message.TWEET, [0,1], "Bobby McDole was known to be a frequent whisky drinker.", 0.85)
    m(Message.TWEET, [2], "God bless McDoles soul!!! #rip", 0.25)
    m(Message.TWEET, [], "#rip #mcdole", 0.25)
    m(Message.NOTE, [0,1], "Famous Musican Bobby McDole dies in car crash.")
