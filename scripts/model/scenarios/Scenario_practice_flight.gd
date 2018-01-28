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
    headlines.append(Headline.new("Training flight of {Country_1} went wrong, causing international conflict.",0.35,0.42,0.70))
    headlines.append(Headline.new("{Country_1}s military pilots accidentaly crossed border on training flight.",0.40,0.50,0.60))
    headlines.append(Headline.new("{Country_1}s army made mistake while drill. Pilot crossing border of {Country_2}.",0.65,0.50,0.40))
    headlines.append(Headline.new("{Country_1}s army is advancing over border of {Country_2}",0.55,0.70,0.50))
    headlines.append(Headline.new("{Country_1}s army provoked {Country_2} with drill mistake at border.",0.37,0.60,0.80))


func init_messages():
    messages.append(Message.new(Message.TWEET, [4], "Crazy pilot provoking war!"))
    messages.append(Message.new(Message.TWEET, [0,4], "Was the political conflict at the border really an accident?.", 0.38))
    messages.append(Message.new(Message.TWEET, [1,2,3], "{Country_1}s pilot flight over border was only a mistake.", 0.55))

    messages.append(Message.new(Message.NOTE, [1,3], "{Country_1} has conducted a practice flight at the border to {Country_2}."))
    messages.append(Message.new(Message.NOTE, [3], "{Country_1} prepares for possible war by mobilizing troupes at the border of {Country_2}."))
    messages.append(Message.new(Message.NOTE, [1], "{Country_1} drills units against possible invasion of {Country_2}."))
    messages.append(Message.new(Message.NOTE, [0,4], "{Country_1} deliberately accepts accidentaly provoking {Country_2}."))
    messages.append(Message.new(Message.NOTE, [1,2,3,4], "{Country_1}ian jet planes accidentaly flew over border of {Country_2}."))
	
    messages.append(Message.new(Message.PHAX, [1,2], "{Country_1} ordered only a standard training flight at the border to {Country_2}.", 0.25))
    messages.append(Message.new(Message.PHAX, [2], "One of the {Country_1} pilots flew off to wrong coordinates after radio miscommunication.", 0.48))
    messages.append(Message.new(Message.PHAX, [0,2], "{Country_1}s generals have issued an official appology on the matter.", 0.66))
	