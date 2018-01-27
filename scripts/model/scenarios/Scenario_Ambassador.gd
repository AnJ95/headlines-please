extends "res://scripts/model/Scenario.gd"

const Headline = preload("res://scripts/model/Headline.gd")
const Message = preload("res://scripts/model/Message.gd")

func _init():
    name = "Ambassador died"
    num_countries = 2
    init_headlines()
    init_messages()

func prepare(world, countries):
    for h in headlines:
        h.prepare(world, countries)
    for m in messages:
        m.prepare(world, countries)

func get_propability(world, countries):
    return randf() < 0.05

#TODO set an effect for each Headline

func init_headlines():
    headlines.append(Headline.new("{country_1}s Amassador in {country_2} in hospital."))
    headlines.append(Headline.new("{country_1}s Amassador in {country_2} died."))
    headlines.append(Headline.new("{country_2}: Amassador of {country_1} died under unresolved circumstances."))
    headlines.append(Headline.new("{country_1}s Amassador in {country_2} was murdered."))
    headlines.append(Headline.new("{country_1}s Amassador in {country_2} was poisoned! Was the secret service involved?"))
    headlines.append(Headline.new("{country_1}s Amassador in {country_2} died! Secret service possible?!"))
    headlines.append(Headline.new("{country_2}: {country_2}s Amassador was arrested."))


func init_messages():
    messages.append(Message.new(Message.TWITTER, [1,2], "I heard gun shots near {country_1}s embassy. Did something happen?"))
    messages.append(Message.new(Message.NOTE, [1,2,3,4,5], "It's still unclear whether the secret service of {country_2} was responsible for the death of {country_1}s ambassador"))
    messages.append(Message.new(Message.LIVE, [1,3], "The autopsy finds toxic substances in the Ambassadors body"))
    messages.append(Message.new(Message.TWITTER, [0,2], "Hallo Welt"))
