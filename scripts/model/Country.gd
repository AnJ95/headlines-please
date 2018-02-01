var name = ""

const MIN_INHABITANTS = 10
const MAX_INHABITANTS = 100

const MIN_RELATIONSHIP = 0.25
const MAX_RELATIONSHIP = 0.75

const MIN_PARAM = 0.25
const MAX_PARAM = 0.75

const MAX_READERS_CHANGE = 0.08
const MAX_PARAM_CHANGE = 0.08

var inhabitants = randi() % (MAX_INHABITANTS - MIN_INHABITANTS) + MIN_INHABITANTS

var happyness = randf() * (MAX_PARAM - MIN_PARAM) + MIN_PARAM
var economy = randf() * (MAX_PARAM - MIN_PARAM) + MIN_PARAM

var params = {
    "democracy" : randf() * (MAX_PARAM - MIN_PARAM) + MIN_PARAM,
    "tolerance" : randf() * (MAX_PARAM - MIN_PARAM) + MIN_PARAM,
    "progress" : randf() * (MAX_PARAM - MIN_PARAM) + MIN_PARAM,
    "science" : randf() * (MAX_PARAM - MIN_PARAM) + MIN_PARAM,
    "culture" : randf() * (MAX_PARAM - MIN_PARAM) + MIN_PARAM
}
var readers = 0.1 # between 0 and 1, representing fraction of inhabitants
var relationships = {} # between 0 and 1, 1 for each other country

func _init(name):
    self.name = name

func prepare(world):
    for c in world.countries:
        if c.name == self.name:
            continue
        relationships[c.name] = randf() * (MAX_RELATIONSHIP - MIN_RELATIONSHIP) + MIN_RELATIONSHIP

func broadcast_headline(headline):
    print("country before: " + params_to_string(params) + " readers: " + str(readers))
    var sum_dist = 0 # sth between 0 (best case) and params_num (worst case)
    for p in headline.params:
        # assert: country params in (0,1]
        #         headline params in (0,1)
        var dist = headline.params[p]- params[p]
        params[p] += dist * MAX_PARAM_CHANGE * readers
        sum_dist += abs(dist)
    var norm_dist = sum_dist / params.size()

    readers += (0.5 - norm_dist) * 2 * MAX_READERS_CHANGE * headline.drama
    print("country after: " + params_to_string(params) + " readers: " + str(readers))