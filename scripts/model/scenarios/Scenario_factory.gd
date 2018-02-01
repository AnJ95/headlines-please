extends "res://scripts/model/Scenario.gd"

func _init():
    name = "Factory closing"
    num_countries = 2
    init_headlines()
    init_messages()

func get_propability(world, countries):
    return randf() < 0.05

#TODO set an effect for each Headline

func init_headlines():
    h("Industrialist Handlers stock gambling leaves his workers unemployed.", 0.20, {

    })
    h("Industrialist Handler looses on stock market and has to fire all workers.", 0.28, {

    })
    h("Handler Glass Company has to close factory, dismissing the workers.", 0.39, {

    })
    h("Handler Glass has to file for insolvency after stock market crash.", 0.45, {

    })
    h("Handler Glass has to close its doors after 60 years.", 0.52, {

    })


func init_messages():
    m(Message.TWEET, [0,1,2], "What is this? We are getting fired because of Handlers incompetence.")
    m(Message.TWEET, [1,3], "The stock market is crashing lately! Get you money to safety.", 0.38)
    m(Message.TWEET, [2,4], "I felt quite welcome at Handler Glass. Sad we have to leave.", 0.55)

    m(Message.NOTE, [2], "Industrialist William Handler has to close his last glass factory.")
    m(Message.NOTE, [1,2,3], "Workers of Handler are not getting compensated for sudden loss of job.")
    m(Message.NOTE, [4], "Handler inherited the 60 year old company after his fathers death.")
    m(Message.NOTE, [1,3], "Handler tried to get money via stocks to save his company from ruin.")
    m(Message.NOTE, [3,4], "Handler Glass Company was known for treating workers fairly.")

    m(Message.PHAX, [0,1], "Handler gambled and lost a lot of money on the stock market recently.", 0.25)
    m(Message.PHAX, [2,3], "The market for glass wares was declining for years now.", 0.55)
    m(Message.PHAX, [3,4], "There has been a workers strike recently, halting progress.", 0.55)
