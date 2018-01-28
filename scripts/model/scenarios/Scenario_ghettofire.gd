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
    headlines.append(Headline.new("Public authorities fail to care about a huge fire in Hoffenkamm district.",0.12,0.50,0.82))
    headlines.append(Headline.new("82 people die in tragic fire. Authorities were too late on site.",0.30,0.50,0.52))
    headlines.append(Headline.new("82 people die in tragic fire. Authorities had problems getting to Hoffenkamm.",0.38,0.50,0.52))
    headlines.append(Headline.new("Authorities could not arrive in Hoffenkamm due to damaged and blocked roads.",0.55,0.55,0.45))
    headlines.append(Headline.new("Hoffenkamm roads were impassable. Authorities could not help in local fire.",0.50,0.66,0.65))


func init_messages():
    messages.append(Message.new(Message.TWEET, [3], "I was in a huge crowd in front of the building! Police pushed everyone away."))
    messages.append(Message.new(Message.TWEET, [0], "The fire could only spread because the houses are so old!", 0.38))
    messages.append(Message.new(Message.TWEET, [1], "The fire probably started because of those gangsters meeting in there.", 0.55))

    messages.append(Message.new(Message.NOTE, [0,1,2], "At the time of the fire, the adjacent road was impassable due to neglected and unfinished roadwork."))
    messages.append(Message.new(Message.NOTE, [2,3,4], "On their way to the site, the authorities were stopped by two abandonned cars standing on the street."))
    messages.append(Message.new(Message.NOTE, [2,3], "Hoffenkamm is known for its horrible infrastructure and run down buildings."))
    messages.append(Message.new(Message.NOTE, [2], "The building where the fire started did not meet the building regulation standards."))
    messages.append(Message.new(Message.NOTE, [0,3], "Investigations suggest that the fire started from a faulty wire."))
	
    messages.append(Message.new(Message.PHAX, [1,2], "The local hydrants were incapable of supplying the firefighters.", 0.25))
    messages.append(Message.new(Message.PHAX, [3,4], "Investigators confirmed the source of the fire to be an illegal distillery.", 0.75))
	