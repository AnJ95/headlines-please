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
    h("{country_1}s Amassador in {country_2} in hospital.",1,1,1)
    h("{country_1}s Amassador in {country_2} died.",1,1,1)
    h("{country_2}: Amassador of {country_1} died under unresolved circumstances.",1,1,1)
    h("{country_1}s Amassador in {country_2} was murdered.",1,1,1)
    h("{country_1}s Amassador in {country_2} was poisoned! Was the secret service involved?",1,1,1)
    h("{country_1}s Amassador in {country_2} died! Secret service possible?!",1,1,1)
    h("{country_2}: {country_1}s Amassador was arrested.",1,1,1)
    h("{country_2}: {country_1}s Amassador died after having a stroke.",1,1,1)


func init_messages():
    m(Message.TWEET, [1,2], "I heard gun shots near {country_1}s embassy last night.")
    m(Message.TWEET, [], "What did happen in {country_1}s embassy?", 0.1)
    m(Message.TWEET, [], "press conference cancelled = free afternoon yay", 0.2)

    m(Message.NOTE, [0], "Pressconference cancelled")
    m(Message.NOTE, [0], "Late last night Karl Gustav, {country_1}s ambassador in {country_2}, was brought to the hospital.")
    m(Message.NOTE, [2], "An Autopsy will be conducted after the ambassadors death")
    m(Message.NOTE, [1,2,3,4,5], "It's still unclear whether the secret service of {country_2} was responsible for the death of {country_1}s ambassador")

    m(Message.PHAX, [1,3], "Because of ... an autopsy of the dead ambassador was issued.", 0.25)
    m(Message.PHAX, [1,3], "The autopsy finds toxic substances in the ambassadors body", 0.66)
