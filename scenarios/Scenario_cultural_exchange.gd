extends "res://scripts/model/Scenario.gd"

func _init():
    name = "Cultural Exchange"
    num_countries = 3
    init_headlines()
    init_messages()
    
func is_valid(world, countries):
    var relation_value = world.relations.get_by_country_names(countries[0].name, countries[1].name)
    if not relation_value > 0.5:
        return false
        
    return true


func init_headlines():
    h("{country_1} and {country_2} promoting cultural exchange", 0.5, {
        "culture" : 0.5,
        "tolerance" : 0.3
    }, [
        [1,2,0.3]
    ])
    h("{country_1} and {country_2} strenghening their bond with exchange programs", 0.4, {
        "progress" : 0.5,
        "tolerance" : 0.4
    }, [
        [1,2,0.4]
    ])
    h("Are {country_1} and {country_2} slowly uniting?", 0.55, {
        "progress" : -0.3,
        "tolerance" : -0.2
    }, [
        [1,3,-0.2],
        [2,3,-0.2]
    ])
    h("{country_1} and {country_2} \"share common ideas\"", 0.3, {
        "progress" : 0.3
    }, [
        [1,2,0.18]
    ])
    h("Are {country_1} and {country_2} uniting for a war??", 0.8, {
        "progress" : -0.4,
        "tolerance" : -0.5
    }, [
        [1,3,-0.5],
        [2,3,-0.5]
    ])


func init_messages():
    m(Message.TWEET, [], "I go to {country_1} every year for the holidays", 0.1)
    m(Message.TWEET, [2], "{country_1} <3 {country_2}", 0.25)
    m(Message.TWEET, [4], "{country_1} and {country_2} together are creepy", 0.5)
    m(Message.TWEET, [1], "my son is in {country_2} as an exchange student RIGHT NOW!", 0.2)
    
    m(Message.NOTE, [1], "Politicians in {country_1} and {country_2} are discussing exchange programs", 0.1)
    m(Message.NOTE, [3], "{country_1}s President: \"we and {country_2} share some common ideas for the future\"", 0.25)
    m(Message.NOTE, [2], "{country_1} and {country_2} state to promote mutual trade, education and possibly common military", 0.4)

    m(Message.PHAX, [0], "{country_1} and {country_2}s exchange programs seem to focus on cultural and educational exchange.", 0.3)
    m(Message.PHAX, [4], "{country_2} sergeant confirming common military plans", 0.5)
