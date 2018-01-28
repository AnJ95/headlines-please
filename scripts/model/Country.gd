var name = ""

var economic_strength = 0.0
var citizen_satisfaction = 0.0
var xenophobie = 0.0

var relationships = {}

func _init(name):
    self.name = name
    economic_strength = randf()
    citizen_satisfaction = randf()
    war_enthusiasm = randf()

func prepare(world):
    for c in world.countries:
        if c.name == self.name:
            continue
        relationships[c.name] = randf()
