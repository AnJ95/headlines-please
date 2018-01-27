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
    headlines.append(Headline.new("{country_1}s Amassador in {country_2} in hospital."))
    headlines.append(Headline.new("{country_1}s Amassador in {country_2} died."))
    headlines.append(Headline.new("{country_2}: Amassador of {country_1} died under unresolved circumstances."))
    headlines.append(Headline.new("{country_1}s Amassador in {country_2} was murdered."))
    headlines.append(Headline.new("{country_1}s Amassador in {country_2} was poisoned! Was the secret service involved?"))
    headlines.append(Headline.new("{country_1}s Amassador in {country_2} died! Secret service possible?!"))
    headlines.append(Headline.new("{country_2}: {country_1}s Amassador was arrested."))
    headlines.append(Headline.new("{country_2}: {country_1}s Amassador died after having a stroke."))


func init_messages():
    messages.append(Message.new(Message.TWITTER, [1,2], "I heard gun shots near {country_1}s embassy last night. Did something happen?"))
    messages.append(Message.new(Message.TWITTER, [], "pressconference canceled = free afternoon yay"))
    messages.append(Message.new(Message.TWITTER, [0,2], "Hallo Welt", 0.5))

    messages.append(Message.new(Message.NOTE, [0], "Pressconference canceled"))
    messages.append(Message.new(Message.NOTE, [0], "Late last night Karl Gustav, {country_1}s Ambassador in {country_2}, was brought to the hospital."))
    messages.append(Message.new(Message.NOTE, [], "After the death of the aAutopsy"))
    messages.append(Message.new(Message.NOTE, [1,2,3,4,5], "It's still unclear whether the secret service of {country_2} was responsible for the death of {country_1}s ambassador"))

    messages.append(Message.new(Message.TELEGRAPH, [1,3], "Because of ... an autopsy of the dead ambassador was issued.", 0.25))
    messages.append(Message.new(Message.TELEGRAPH, [1,3], "The autopsy finds toxic substances in the ambassadors body", 0.66))
