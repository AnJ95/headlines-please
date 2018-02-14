var relations
var countries
var scenarios = []
var last_day_progress = -1
var current_scenarios = {}
var past_scenarios = []
const Scenario = preload("res://scripts/model/Scenario.gd")

func _init(relations, countries, scenarios):
    self.relations = relations
    self.countries = countries
    self.scenarios = scenarios

func check_for_new_messages(signal_emitter, day_progress):
    for s in current_scenarios:
        for m in current_scenarios[s].messages:
            if m.arrival_time > last_day_progress && m.arrival_time <= day_progress:
                signal_emitter.emit_signal("message_arrived", m);
    last_day_progress = day_progress

# currently unused
func load_scenarios():
    return
    var dir = Directory.new()
    if dir.open("res://scripts/model/scenarios") == OK:
        dir.list_dir_begin(true)
        var file_name = dir.get_next()
        while (file_name != ""):
            if dir.current_is_dir():
                continue
            var LoadedScenario = load("res://scripts/model/scenarios/" + file_name)
            scenarios.append(LoadedScenario.new())
            file_name = dir.get_next()
        dir.list_dir_end ( )
    else:
        print("An error occurred when trying to access the path.")


func next_day():
    current_scenarios = {}
    
    # This gives us a data structure of all valid scenarios with every country permutation possibility
    var scenarios_valid_perms = filter_by_preconditions(scenarios)
    
    # This selects just one of these possibilities and prepares the scenario with its corresponding country permutation
    var scenarios_valid = select_one_per_scenario(scenarios_valid_perms)

    var scenario_count = 1#2 + randi() % 2
    if scenario_count > scenarios_valid.size():
        print("ERROR, did not find enough valid scenarios")
        return
    
    # Finally we just need to get exactly scenario_count of the scenarios, taking their corresponding probabilities into account
    current_scenarios = select_at_random(scenarios_valid, scenario_count)

func select_at_random(scenarios, amount):
    var result = {}
    # repeat until we got exactly as many scenarios as we want
    while result.size() < amount:
        # iterate all valid scenarios in random order
        fisher_yates(scenarios)
        for scenario in scenarios:
            # check probability
            if randf() <= scenario.prob:
                result[scenario.name] = scenario
                if result.size() >= amount:
                    break
    return result

# Takes the data structure, filter_by_preconditions returns and randomly selects one country permutation per scenario 
func select_one_per_scenario(scenarios):
    # Iterate valid scenarios
    var result = []
    for scenario_name in scenarios:
        var perm_possibilites = scenarios[scenario_name]
        # Randomly select a country permutation
        var tuple = perm_possibilites[randi() % perm_possibilites.size()]
        # Prepare and add this scenario
        tuple[0].prepare(self, tuple[1])
        result.append(tuple[0])
    return result

# Filters an array of scenarios and returns a data structure containing results and information about its countries        
""" Example return:
   {
    "Ghettofire": [
        [scenario_object, [country_1_object]],
        [scenario_object, [country_4_object]]
    ]
    "This is war": [
        [scenario_object, [country_1_object, country_2_object]]
        [scenario_object, [country_1_object, country_3_object]]
    ]
   } 
"""
func filter_by_preconditions(src):
    var dst = {}
    
    # iterate every scenario
    for scenario in src:
        var perms = get_all_coutry_permutations(scenario.num_countries)
        
        # iterate every country combination possibility
        for perm in perms:
            var valid = true
            
            # iterate each relation-precondition of this scenario
            for condition in scenario.relation_conditions:
                var val_actual = relations.get_by_country_names(perm[condition[0] - 1].name, perm[condition[1] - 1].name)
                var val_thresh = condition[3]
                if condition[2] == Scenario.Op.GREATER and val_actual <= val_thresh:
                    valid = false
                if condition[2] == Scenario.Op.LESS and val_actual >= val_thresh:
                    valid = false
            
            # iterate each country that has preconditions
            for country_num in scenario.param_conditions:
                var countries_preconditions = scenario.param_conditions[country_num]
                var country = perm[country_num - 1]
                
                # iterate each param-precondition of this country
                for condition in countries_preconditions:
                    var val_actual = country.params[condition[0]]
                    var val_thresh = condition[2]
                    if condition[1] == Scenario.Op.GREATER and val_actual <= val_thresh:
                        valid = false
                    if condition[1] == Scenario.Op.LESS and val_actual >= val_thresh:
                        valid = false

            if valid:
                if !dst.has(scenario.name):
                    dst[scenario.name] = []
                dst[scenario.name].append([scenario, perm])
    return dst

func filter_by_probability(src):
    pass

func get_scenario():
    var s_num = randi() % scenarios.size()
    var s = scenarios[s_num]
    var s_countries = []
    for i in range(s.num_countries):
        s_countries.append(countries[i])
    fisher_yates(s_countries)
    s.prepare(self, s_countries)
    return s

    for s in scenarios:
        var num_countries = s.num_countries
        if s.get_propability(self):
           pass

# Used by scenarios to format their strings using their selected countries
func make_format_dic(countries):
    var format_dic = {}
    for c in range(countries.size()):
       format_dic["country_" + str(c + 1)] = countries[c].name
    return format_dic

# Returns an array of all possible country arrays with a given length
func get_all_coutry_permutations(country_amount, yets = [[]]):
    var new_yets = []
    for yet in yets:
        for country in countries:
            if !yet.has(country):
                var new_yet = yet.duplicate()
                new_yet.append(country)
                new_yets.append(new_yet)
    if country_amount == 1:
        return new_yets
    else:
        return get_all_coutry_permutations(country_amount - 1, new_yets)

# Shuffles an array
func fisher_yates(array):
    for i in range(0, array.size()-2):
        var j = i + randi() % (array.size() - i)
        var tmp = array[j]
        array[j] = array[i]
        array[i] = tmp