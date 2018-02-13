const MIN_RELATIONSHIP = 0.25
const MAX_RELATIONSHIP = 0.75
var relationships = []
var country_names = []

func _init(countries):
    for i in countries:
        country_names.append(i.name)
    for i in range(get_size()):
        print(i)
        relationships.append(randf() * (MAX_RELATIONSHIP - MIN_RELATIONSHIP) + MIN_RELATIONSHIP)

func get_by_relation_id(id):
    if id < 0 or id >= get_size():
        print("Tried getting country relationship with invalid id " + id)
        return null
    return relationships[id]
    
func get_by_country_names(name_a, name_b):
    if name_a == name_b:
        print("Tried getting country relationship with two equal names " + name_a)
        return
    var id_a = -1
    var id_b = -1
    for i in range(country_names):
        if country_names[i].name == name_a:
            id_a = i
        if country_names[i].name == name_b:
            id_b = i
    
    return get_by_relation_id(get_relation_id_by_country_ids(id_a, id_b))

func get_relation_id_by_country_ids(a, b):
    if a == b:
        print("Tried getting country relationship with two equal ids " + str(a))
        return -1
    var id_min = a
    var id_max = b
    if id_min > id_max:
        id_min = b
        id_max = a
        
    var i = 0
    var i_a = 0
    var i_b = 0
    while true:
        if i_a < i_b:
            i += 1
        if i_a == id_min and i_b == id_max:
            return i - 1
        i_b += 1
        if i_b >= country_names.size():
            i_b = 0
            i_a += 1
            if i_a >= country_names.size():
                print("Tried getting country relationship with invalid ids " + str(a) + " and " + str(b))
                return -1
        
    
func get_size():
    var n = country_names.size()
    return int(round(n*(n-1)/2))