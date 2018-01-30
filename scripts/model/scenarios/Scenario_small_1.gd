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
    h("Scientist found new way of refining salt.",0.50,0.50,0.07)
    h("Online gaming produces minerals, scientist found.",0.50,0.50,0.16)


func init_messages():
    m(Message.NOTE, [0,1], "Prof. Harold Hegsworth found new way of producing sodium via online gaming.")
