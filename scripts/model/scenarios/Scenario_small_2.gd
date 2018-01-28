extends "res://scripts/model/Scenario.gd"

const Headline = preload("res://scripts/model/Headline.gd")
const Message = preload("res://scripts/model/Message.gd")

func _init():
    name = "Ambassador died"
    num_countries = 2
    init_headlines()
    init_messages()

func get_propability(world, countries):
    return randf() < 0.05

#TODO set an effect for each Headline

func init_headlines():
    headlines.append(Headline.new("Singer McDole dies in car crash due to drunkenness.", 0.50,0.50,0.21))
    headlines.append(Headline.new("Singer McDole passed away in tragic accident.", 0.50,0.50,0.14))


func init_messages():
    messages.append(Message.new(Message.TWEET, [0,1], "Bobby McDole was known to be a frequent whisky drinker.", 0.85))

    messages.append(Message.new(Message.NOTE, [0,1], "Famous Musican Bobby McDole dies in car crash."))

	