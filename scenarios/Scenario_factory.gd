extends "res://scripts/model/Scenario.gd"

func _init():
    name = "Factory closing"
    num_countries = 1
    init_headlines()
    init_messages()


func init_headlines():
    h("Industrialist Handlers stock gambling leaves his workers unemployed.", 0.3, {
        "democracy" : 0.3,
        "tolerance" : -0.3
    })
    h("Worker class victim of stock gambling!", 0.5, {
        "democracy" : 0.6,
    })
    h("Handler Glass Company has to close factory, firing all workers!", 0.4, {
        "democracy" : 0.2,
        "tolerance" : -0.4
    })
    h("Handler Glass has to file for insolvency after miss investments", 0.3, {
        "progress" : -0.32,
    })
    h("Handler Glass has to close its doors after 60 years.", 0.3, {
        "progress" : 0.4
    })
    


func init_messages():
    m(Message.TWEET, [1], "What is this? We are getting fired because of Handlers incompetence.")
    #m(Message.TWEET, [1,3], "The stock market is crashing lately! Get you money to safety.", 0.38)
    m(Message.TWEET, [4], "I felt quite welcome at Handler Glass. Sad we have to leave.", 0.55)

    m(Message.NOTE, [2], "Industrialist William Handler has to close his last glass factory.")
    #m(Message.NOTE, [4], "Handler inherited the 60 year old company after his fathers death.")
    m(Message.NOTE, [1,3], "Handler tried to get money via stocks to save his company from ruin.")

    m(Message.PHAX, [0,1], "Handler gambled and lost a lot of money on the stock market recently.", 0.25)
    m(Message.PHAX, [2], "Workers of Handler are not getting compensated for sudden loss of job.")
    #m(Message.PHAX, [2,3], "The market for glass wares was declining for years now.", 0.55)
    #m(Message.PHAX, [], "There has been a workers strike recently, halting progress.", 0.55)
