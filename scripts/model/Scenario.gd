
const Headline = preload("res://scripts/model/Headline.gd")
const Message = preload("res://scripts/model/Message.gd")
enum Op {GREATER, LESS}

# values to be set by concrete scenario
var name = "test scenario"
var prob = 1
var num_countries = 1
var countries = []

var messages = []
var headlines = []

var param_conditions = {
        1 : [
            ["progress", GREATER, 2]
        ],
    }

func prepare(scenarioManager, countries):
    self.countries = countries
    for h in headlines:
        h.prepare(scenarioManager, self)
    for m in messages:
        m.prepare(scenarioManager, self)

func h(format_string, drama, params, relations=[]):
    headlines.append(Headline.new(format_string, drama, params, relations))
    
func m(type, headlines, format_string, arrival_time = -1):
    messages.append(Message.new(type, headlines, format_string, arrival_time))



