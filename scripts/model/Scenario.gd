
const Headline = preload("res://scripts/model/Headline.gd")
const Message = preload("res://scripts/model/Message.gd")

# values to be set by concrete scenario
var name = "test scenario"
var prob = 1
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

func is_valid(world, countries):
    return true

func get_propability():
    return 1

func h(format_string, drama, params, relations=[]):
    headlines.append(Headline.new(format_string, drama, params, relations))

func m(type, headlines, format_string, arrival_time = -1):
    messages.append(Message.new(type, headlines, format_string, arrival_time))



