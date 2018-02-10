extends "res://scripts/model/Scenario.gd"

func _init():
    name = "Online Salt"
    num_countries = 2
    init_headlines()
    init_messages()

func get_propability(world, countries):
    return randf() < 0.05

#TODO set an effect for each Headline

func init_headlines():
    h("Scientist found new way of refining salt.", 0.3, {
      "science" : 0.3
    })
    h("Online gaming produces minerals, scientist found.", 0.4, {
      "science" : 0.2,
      "culture" : 0.1
    })
    h("Online games pave way for scientific discoveries", 0.6, {
      "science" : 0.4,
      "culture" : 0.2
    })


func init_messages():
    m(Message.NOTE, [0,1], "Prof. Harold Hegsworth found new way of producing sodium via online gaming.")
    m(Message.PHAX, [2], "Hegsworth: \"There will be more we can learn from the world of online gaming\"", 0.2)
    m(Message.PHAX, [0], "Breakthrough in salt refining processes")
    m(Message.TWEET, [1], "onlinegaming ftw #hegsworth #salty")
