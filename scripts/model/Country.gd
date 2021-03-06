var name = ""

const MIN_INHABITANTS = 10
const MAX_INHABITANTS = 100

const MIN_PARAM = -0.6
const MAX_PARAM = 0.6

const MIN_READERS = 0.08
const MAX_READERS = 0.12

const MIN_HAPPYNESS = 0.5
const MAX_HAPPYNESS = 0.8

const MAX_READERS_CHANGE = 0.08
const MAX_PARAM_CHANGE = 0.4

var inhabitants = randi() % (MAX_INHABITANTS - MIN_INHABITANTS) + MIN_INHABITANTS

var readers = randf() * (MAX_READERS - MIN_READERS) + MIN_READERS
var happyness = randf() * (MAX_HAPPYNESS - MIN_HAPPYNESS) + MIN_HAPPYNESS

var country_info_pos

var params = {
    "democracy" : 0,
    "tolerance" : 0,
    "progress" : 0,
    "science" : 0,
    "culture" : 0
}


func _init(name, country_info_pos):
    self.name = name
    self.country_info_pos = country_info_pos
    
func get_readers():
    return inhabitants * readers

func prepare(world):
    for p in params:
        params[p] = randf() * (MAX_PARAM - MIN_PARAM) + MIN_PARAM
    for c in world.countries:
        if c.name == self.name:
            continue

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
