var name = ""

const MIN_INHABITANTS = 10
const MAX_INHABITANTS = 100

const MIN_RELATIONSHIP = 0.25
const MAX_RELATIONSHIP = 0.75

var inhabitants = 0
var params = {
    "economy" : 0.5,
    "satisfaction" : 0.5,
    "xenophobia" : 0.5
}
var readers = 0.1 # between 0 and 1, representing fraction of inhabitants
var relationships = {} # between 0 and 1, 1 for each other country

func _init(name):
    self.name = name

func prepare(world):
    inhabitants = randi() % (MAX_INHABITANTS - MIN_INHABITANTS) + MIN_INHABITANTS
    for c in world.countries:
        if c.name == self.name:
            continue
        relationships[c.name] = randf() * (MAX_RELATIONSHIP - MIN_RELATIONSHIP) + MIN_RELATIONSHIP
