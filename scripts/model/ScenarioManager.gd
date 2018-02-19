var world
var relations
var countries
var scenarios = []
var last_day_progress = -1
var current_scenarios = {}
var past_scenarios = []
const Scenario = preload("res://scripts/model/Scenario.gd")
const MIN_SCENARIO_DAY_DISTANCE = 3
const MIN_SCENARIOS_PER_DAY = 2
const MAX_SCENARIOS_PER_DAY = 3

func _init(world, relations, countries, scenarios):
    self.world = world
    self.relations = relations
    self.countries = countries
    self.scenarios = scenarios
    load_user_scenarios()

func check_for_new_messages(signal_emitter, day_progress):
    for s in current_scenarios:
        for m in current_scenarios[s].messages:
            if m.arrival_time > last_day_progress && m.arrival_time <= day_progress:
                signal_emitter.emit_signal("message_arrived", m);
    last_day_progress = day_progress

# load additional scenarios from the user dircetory (on Linux ~/.local/share/godot/app_userdata/HeadlinesPlease/scenarios)
func load_user_scenarios():
    var dir = Directory.new()
    if dir.open("user://scenarios") == OK:
        dir.list_dir_begin(true)
        var file_name = dir.get_next()
        while (file_name != ""):
            if dir.current_is_dir():
                continue
            var LoadedScenario = load("user://scenarios/" + file_name)
            LoadedScenario = LoadedScenario.new()
            scenarios.append(LoadedScenario)
            print("added " + LoadedScenario.name + " from user://scenarios/" + file_name)
            file_name = dir.get_next()
        dir.list_dir_end()
    else:
        print("An error occurred when trying to access the path.")


func next_day():
    current_scenarios = {}
    
    var scenarios_unused = filter_by_occurence(scenarios)
    
    # This gives us a data structure of all valid scenarios with every country permutation possibility
    var scenarios_valid_perms = filter_by_preconditions(scenarios_unused)
    
    # This selects just one of these possibilities and prepares the scenario with its corresponding country permutation
    var scenarios_valid = select_one_per_scenario(scenarios_valid_perms)

    var scenario_count = rand_range(MIN_SCENARIOS_PER_DAY, MAX_SCENARIOS_PER_DAY)
    if scenario_count > scenarios_valid.size():
        print("ERROR, did not find enough valid scenarios")
        return
    
    # Finally we just need to get exactly scenario_count of the scenarios, taking their corresponding probabilities into account
    current_scenarios = select_at_random(scenarios_valid, scenario_count)
    
    print("Serving " + str(current_scenarios.size()) + " scenarios")
    var scenario_str = ""
    for s in current_scenarios:
        scenario_str += s + " - "
    print(scenario_str)
    
    # Also save these selected scenarios name
    past_scenarios.append([])
    for scenario_name in current_scenarios:
        past_scenarios[past_scenarios.size() - 1].append([scenario_name, current_scenarios[scenario_name].countries])

func filter_by_occurence(scenarios):
    var result = []
    for scenario in scenarios:
        var valid = true
        var day = past_scenarios.size() - MIN_SCENARIO_DAY_DISTANCE
        if day < 0:
            day = 0
        while day < past_scenarios.size():
            for past_scenario in past_scenarios[day]:
                if past_scenario[0] == scenario.name:
                    valid = false
            day += 1
        if valid:
            result.append(scenario)
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
func filter_by_preconditions(scenarios):
    var result = {}
    
    # iterate every scenario
    for scenario in scenarios:
        var perms = get_all_coutry_permutations(scenario.num_countries)
        
        # iterate every country combination for this scenario and check if it is valid
        for countries_permutation in perms:            
            if scenario.is_valid(world, countries_permutation):
                if !result.has(scenario.name):
                    result[scenario.name] = []
                result[scenario.name].append([scenario, countries_permutation])
    return result

# TODO: does this work? a check to not select multiple of the same scenario is neeed (currently done by "select_one_per_scenario"
# but im am not happy with the math
func select_by_probability(scenarios, amount):
    var result = {}
    while result.size() < amount:
        var total_prob = 0
        for scenario in scenarios:
            total_prob += scenario.prob
            
        var rand = rand_range(0, total_prob)
        
        var last_prob = 0;
        var cur_prob = 0;
        for scenario in scenarios:
            cur_prob += scenario.prob
            if rand >= last_prob && rand < cur_prob:
                result.append(scenario)
            last_prob = cur_prob
            
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
    
# did a scenario happen for this exact country combination (if empty countries then any combination)
func did_scenario_happen(scenario, country_combination = []):
    for day in past_scenarios:
        for past_scenario in day:
            if past_scenario[0] == scenario && (country_combination == [] || country_combination == past_scenario[1]) :
                return true

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
