var name = ""

const MIN_INHABITANTS = 10
const MAX_INHABITANTS = 100

const MIN_RELATIONSHIP = 0.25
const MAX_RELATIONSHIP = 0.75

const MIN_PARAM = -0.6
const MAX_PARAM = 0.6

const MAX_READERS_CHANGE = 0.08
const MAX_PARAM_CHANGE = 0.08

var inhabitants = randi() % (MAX_INHABITANTS - MIN_INHABITANTS) + MIN_INHABITANTS

var happyness = randf() * (MAX_PARAM - MIN_PARAM) + MIN_PARAM
var economy = randf() * (MAX_PARAM - MIN_PARAM) + MIN_PARAM

var params = {
    "democracy" : 0,
    "tolerance" : 0,
    "progress" : 0,
    "science" : 0,
    "culture" : 0
}
var readers = 0.1 # between 0 and 1, representing fraction of inhabitants
var relationships = {} # between 0 and 1, 1 for each other country

var country_info_pos

func _init(name, country_info_pos):
    self.name = name
    self.country_info_pos = country_info_pos

func prepare(world):
    for p in params:
        params[p] = randf() * (MAX_PARAM - MIN_PARAM) + MIN_PARAM
    for c in world.countries:
        if c.name == self.name:
            continue
        relationships[c.name] = randf() * (MAX_RELATIONSHIP - MIN_RELATIONSHIP) + MIN_RELATIONSHIP

func broadcast_headline(headline):
    print("country before: " + str(params) + " readers: " + str(readers))
    var sum_dist = 0 # sth between 0 (best case) and params_num (worst case)

    for p in headline.params:
        var dist = headline.params[p] - params[p]
        params[p] += headline.params[p] * MAX_PARAM_CHANGE * readers * sigmoid(abs(dist))
        sum_dist += abs(dist)

    if headline.params.size() != 0:
        var norm_dist = (sum_dist / headline.params.size()) / 2
        readers += anti_sigmoid(norm_dist) * MAX_READERS_CHANGE * headline.drama


    print("country after: " + str(params) + " readers: " + str(readers))

func sigmoid(x):
  if x <= 1:
    return 1
  return sin(x * PI / 2)

func anti_sigmoid(x):
    return 1 - 2 * sin(x * PI / 2)
