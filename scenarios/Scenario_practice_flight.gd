extends "res://scripts/model/Scenario.gd"

func _init():
    name = "Practice Flight"
    num_countries = 2
    init_headlines()
    init_messages()
    
func is_valid(world, countries):
    var relation_value = world.relations.get_by_country_names(countries[0].name, countries[1].name)
    if not relation_value < -0.2:
        return false
        
    return true


func init_headlines():
    h("Training flight of {country_1} went wrong, causing international conflict.", 0.70, {
      "progress" : -0.4,
      "tolerance" : -0.2
    })
    h("{country_1}s military pilots accidentaly crossed border on training flight.", 0.30, {
      "progress" : -0.1,
      "tolerance" : 0
    })
    h("{country_1}s army made mistake while drill. Pilot crossing border of {country_2}.", 0.40, {
      "progress" : -0.13,
      "tolerance" : -0.1
    })
    h("{country_1}s army is advancing over border of {country_2}", 0.80, {
      "progress" : -0.3,
      "tolerance" : -0.2,
      "democracy" : -0.3
    }, [
        [1, 2, -0.7]
    ])
    h("{country_1}s army provoked {country_2} with drill mistake at border.", 0.50, {
      "progress" : -0.2,
      "tolerance" : -0.1
    }, [
        [1, 2, -0.3]
    ])


func init_messages():
    m(Message.TWEET, [3], "Crazy pilot provoking war!")
    m(Message.TWEET, [3], "accident? rly?", 0.38)
    m(Message.TWEET, [1,2,3], "{country_1}s pilot flight over border was just a mistake #chillout", 0.55)

    m(Message.NOTE, [4], "{country_1} has conducted a practice flight at the border to {country_2}.")
    m(Message.NOTE, [3], "{country_1}ian military airplane just crossed the border of {country_2}!")
    #m(Message.NOTE, [3], "{country_1} drills units against possible invasion of {country_2}.")
    #m(Message.NOTE, [0,4], "{country_1} deliberately accepts accidentaly provoking {country_2}.")
    #m(Message.NOTE, [1,2,3,4], "{country_1}ian jet planes accidentaly flew over border of {country_2}.")

    m(Message.PHAX, [0, 1], "{country_1} ordered only a standard training flight at the border to {country_2}.", 0.25)
    m(Message.PHAX, [2], "One of the {country_1} pilots flew off to wrong coordinates after radio miscommunication.", 0.48)
    m(Message.PHAX, [0, 1], "{country_1}s generals have issued an official appology on the matter.", 0.66)
