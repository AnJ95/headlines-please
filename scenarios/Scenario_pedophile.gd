extends "res://scripts/model/Scenario.gd"

func _init():
    name = "Pedophile Bishop"
    num_countries = 1
    init_headlines()
    init_messages()
    
func is_valid(world, countries):
    if not countries[0].params["science"] < 0.2:
        return false
        
    return true


func init_headlines():
    h("No end to pedophilia in church!", 0.75, {
        "science" : 1
    })
    h("Bishop raped multiple children!", 0.5, {
        "science" : 0.6
    })
    h("Pedophile Bishop uncovered after 12 years of abusement!", 0.8, {
        "science" : 0.7,
        "progress" : -0.2
    })
    h("Wrongdoings of serial Pedophile uncovered", 0.3, {
        "democracy" : -0.2,
        "progress" : 0.2
    })


func init_messages():
    m(Message.TWEET, [0], "That rapist bishop shall burn in hell")
    m(Message.TWEET, [], "Religion strikes back! #hideyourwife #hideyourkids")

    m(Message.NOTE, [0,1,3], "Bishop Ainsworth committed sexual harrassment in multiple cases")

    m(Message.PHAX, [2], "First case of sexual assault was 12 years ago", 0.35)
