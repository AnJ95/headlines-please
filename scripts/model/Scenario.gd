
const Headline = preload("res://scripts/model/Headline.gd")
const Message = preload("res://scripts/model/Message.gd")

var name = "test scenario"

var num_countries = 1
var countries = []

var messages = []

var headlines = []

func prepare(world, countries):
    self.countries = countries
    for h in headlines:
        h.prepare(world, self)
    for m in messages:
        m.prepare(world, self)
    

func get_propability(world, countries):
    return 0
    
func h(format_string, satisfaction, bias, drama):
    headlines.append(Headline.new(format_string, satisfaction, bias, drama))
    
func m(type, headlines, format_string, arrival_time = -1):
    messages.append(Message.new(type, headlines, format_string, arrival_time))



