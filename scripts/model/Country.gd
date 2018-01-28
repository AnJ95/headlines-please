var name = ""


var params = {
    "economy" : 0.5,
    "satisfaction" : 0.5,
    "xenophobia" : 0.5
}
var relationships = {}

func _init(name):
    self.name = name

func prepare(world):
    for c in world.countries:
        if c.name == self.name:
            continue
        relationships[c.name] = randf() / 2 + 0.25
