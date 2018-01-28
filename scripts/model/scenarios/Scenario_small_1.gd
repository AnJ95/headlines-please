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
    headlines.append(Headline.new("Scientist found new way of refining salt.",0.50,0.50,0.07))
    headlines.append(Headline.new("Online gaming produces minerals, scientist found.",0.50,0.50,0.16))


func init_messages():
    messages.append(Message.new(Message.NOTE, [0,1], "Prof. Harold Hegsworth found new way of producing sodium via online gaming."))
	