var countries
var scenarios = []
var last_day_progress = -1
var current_scenarios = {}

func _init(countries, scenarios):
    self.countries = countries
    self.scenarios = scenarios

func check_for_new_scenarios(signal_emitter, day_progress):
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
    while current_scenarios.size() < 2:
        var next_scenario = get_scenario()
        if !current_scenarios.has(next_scenario.name):
            current_scenarios[next_scenario.name] = next_scenario

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

func make_format_dic(countries):
    var format_dic = {}
    for c in range(countries.size()):
       format_dic["country_" + str(c + 1)] = countries[c].name
    return format_dic

func fisher_yates(array):
    for i in range(0, array.size()-2):
        var j = i + randi() % (array.size() - i)
        var tmp = array[j]
        array[j] = array[i]
        array[i] = tmp