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

