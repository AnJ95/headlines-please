
const Headline = preload("res://scripts/model/Headline.gd")
const Message = preload("res://scripts/model/Message.gd")

var name = "test scenario"

var num_countries = 1
var countries = []

var messages = []

var headlines = []

func prepare(scenarioManager, countries):
    self.countries = countries
    for h in headlines:
        h.prepare(scenarioManager, self)
    for m in messages:
        m.prepare(scenarioManager, self)
    

func get_propability(world, countries):
    return 0
    
func h(format_string, drama, params, relations=[]):
    headlines.append(Headline.new(format_string, drama, params, relations))
    
func m(type, headlines, format_string, arrival_time = -1):
    messages.append(Message.new(type, headlines, format_string, arrival_time))



