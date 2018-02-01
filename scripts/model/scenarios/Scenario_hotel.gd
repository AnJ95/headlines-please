extends "res://scripts/model/Scenario.gd"

func _init():
    name = "Rampage in Hotel"
    num_countries = 2
    init_headlines()
    init_messages()

func get_propability(world, countries):
    return randf() < 0.05

#TODO set an effect for each Headline

func init_headlines():
    h("{country_1} allows people to treat citizens of {country_2} derogatory.", 0.75, {
      "tolerance" : -0.3,
      "democracy" : 0.1
    })
    h("Racist {country_1}ian hotelowner Eduard Glitz bans other nations from entering.", 0.65, {
      "tolerance" : -0.2,
    })
    h("Controversial {country_1}ian hotelowner bans group of misbehaving foreigners.", 0.42, {
      "tolerance" : 0,
    })
    h("Enraged {country_1}ian hotelowner throws out a group of vandalizing {country_2}ian visitors.", 0.40, {
      "tolerance" : -0.1,
    })
    h("Drunk {country_2}ian hooligans wreck Glitz hotel, get banned.", 0.65, {
      "tolerance" : 0,
    })


func init_messages():
    m(Message.TWEET, [0,1], "The {country_2}ians were cruely beat up by hotel security!")
    m(Message.TWEET, [4], "The {country_2}ians allegedly snuck in and plundered the bar.", 0.38)
    m(Message.TWEET, [1], "Eduard Glitz is known to be a racist, isn't he?", 0.55)

    m(Message.NOTE, [3,4], "{country_2}ians cause $15,000 damage at hotel.")
    m(Message.NOTE, [0,1], "Hotelowner Eduard Glitz forcefully removed group of {country_2}ians.")
    m(Message.NOTE, [1,2], "The misbehaving {country_2}ians recieved a ban from the Glitz hotels.")
    m(Message.NOTE, [2,3], "A group of hooligans caused $8,000 damage at the couches of a hotel lounge.")
    m(Message.NOTE, [3,4], "The hotel vandals were unemployed and at the time heavily intoxicated.")

    m(Message.PHAX, [1], "Hotelowner Eduard Glitz refused to employ the vandals numerous times in the past.", 0.25)
    m(Message.PHAX, [3,4], "The vandals have all a criminal record in property damage or molestation.", 0.48)
