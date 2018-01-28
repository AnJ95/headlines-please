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
    headlines.append(Headline.new("Industrialist Handlers stock gambling leaves his workers unemployed.",0.20,0.55,0.72))
    headlines.append(Headline.new("Industrialist Handler looses on stock market and has to fire all workers.",0.28,0.42,0.66))
    headlines.append(Headline.new("Handler Glass Company has to close factory, dismissing the workers.",0.39,0.50,0.58))
    headlines.append(Headline.new("Handler Glass has to file for insolvency after stock market crash.",0.45,0.53,0.46))
    headlines.append(Headline.new("Handler Glass has to close its doors after 60 years.",0.52,0.62,0.39))


func init_messages():
    messages.append(Message.new(Message.TWEET, [0,1,2], "What is this? We are getting fired because of Handlers incompetence."))
    messages.append(Message.new(Message.TWEET, [1,3], "The stock market is crashing lately! Get you money to safety.", 0.38))
    messages.append(Message.new(Message.TWEET, [2,4], "I felt quite welcome at Handler Glass. Sad we have to leave.", 0.55))

    messages.append(Message.new(Message.NOTE, [2], "Industrialist William Handler has to close his last glass factory."))
    messages.append(Message.new(Message.NOTE, [1,2,3], "Workers of Handler are not getting compensated for sudden loss of job."))
    messages.append(Message.new(Message.NOTE, [4], "Handler inherited the 60 year old company after his fathers death."))
    messages.append(Message.new(Message.NOTE, [1,3], "Handler tried to get money via stocks to save his company from ruin."))
    messages.append(Message.new(Message.NOTE, [3,4], "Handler Glass Company was known for treating workers fairly."))

    messages.append(Message.new(Message.PHAX, [0,1], "Handler gambled and lost a lot of money on the stock market recently.", 0.25))
    messages.append(Message.new(Message.PHAX, [2,3], "The market for glass wares was declining for years now.", 0.55))
    messages.append(Message.new(Message.PHAX, [3,4], "There has been a workers strike recently, halting progress.", 0.55))