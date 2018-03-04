extends "res://scripts/model/Scenario.gd"

func _init():
    name = "Box Urinator"
    num_countries = 2
    init_headlines()
    init_messages()
    
func is_valid(world, countries):
    return true

func init_headlines():
    h("Box champ photographed urinating in public!", 0.4, {
        "progress" : 0.2,
        "culture" : -0.3
    })
    h("Last years boxing champion Ivan Boliks pisses on {country_2}s museum!", 0.55, {
        "culture" : -0.5
    }, [
        [1,2,-0.23]
    ])
    h("The drunk adventures of Ivan Boliks", 0.4, {
        "tolerance" : -0.3,
        "progress" : 0.1
    })
    h("Caught - this months public urinator!", 0.4, {
        "tolerance" : -0.34,
        "progress" : -0.1
    })
    h("Boxer Ivan Boliks blackmailed with public nude photograph!", 0.62, {
        "democracy" : 0.3,
        "progress" : 0.32
    })


func init_messages():
    m(Message.TWEET, [3], "lol #ivan #pissonyou")
    m(Message.TWEET, [4], "Got the link for #ivan #nude send pm")
    m(Message.TWEET, [2], "when ur drunk and walking around the town use toilet!")
    
    m(Message.NOTE, [0], "Box champion urinated in public and gets caught by civilist")
    m(Message.NOTE, [1], "Ivan Boliks urinated on property of the National Museum in {country_2}", 0.4)
    m(Message.NOTE, [2], "Boxer Ivan Boliks was drunk and behaved inappropriately yesterday night in {country_2}", 0.6)
    
    m(Message.PHAX, [4], "Ivan Boliks is supposedly being blackmailed with photographs showing Ivan naked", 0.6)
    m(Message.PHAX, [4], "Police investigation found the blackmailer with over 100 pictures of Ivan Bolisk", 0.8)
    
    
