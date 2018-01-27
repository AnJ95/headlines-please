extends "res://scripts/Scenario.gd"

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
    headlines.append(Headline.new("%ss Amassador in %s in hospital."))
    headlines.append(Headline.new("%ss Amassador in %s died"))
    headlines.append(Headline.new("%ss Amassador in %s died under unresolved circumstances"))
    headlines.append(Headline.new("%ss Amassador in %s was murdered"))
    headlines.append(Headline.new("%ss Amassador in %s was poisoned! Was the secret service involved?"))
    headlines.append(Headline.new("%ss Amassador in %s died! Secret service possible?!"))
    headlines.append(Headline.new("%ss Amassador in %s died! Secret service possible?!"))
    headlines.append(Headline.new("%ss Amassador in %s was arrested"))


func init_messages():
    messages.append(Message.new(Message.TWITTER, [1,2], "I heard gun shots near %ss embassy. Did something happen?"))
    messages.append(Message.new(Message.NOTE, [1,2,3,4,5], "It's still unclear whether the secret service of %s was responsible for the death of %ss ambassador"))
    messages.append(Message.new(Message.LIVE, [1,3], "The autopsy finds toxic substances in the Ambassadors body"))
    messages.append(Message.new(Message.TWITTER, [0,2], "Hallo Welt"))
