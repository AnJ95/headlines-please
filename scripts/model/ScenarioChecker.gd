const DropZone = preload("res://scripts/DropZone.gd")
const Scenario = preload("res://scripts/model/Scenario.gd")
const Message = preload("res://scripts/model/Message.gd")

var names = []

func _init(world, scenarioManager):
    for scenario in scenarioManager.scenarios:
        check(world, scenario)
    for scenario in scenarioManager.scenarios:
        second_check(world, scenario)
    print("##########")
    print("Done checking " + str(scenarioManager.scenarios.size()) + " scenarios ")

func check(world, s):
    print("### checking scenario " + s.name)
    
    if names.has(s.name):
        e("duplicate name")
    names.append(s.name)
    
    if s.num_countries < 0 or s.num_countries > world.countries.size():
        e("invalid num_countries " + str(s.num_countries))
    
    if s.prob < 0 or s.prob > 1:
        e("invalid prob " + str(s.prob))
        
    if s.messages.size() < DropZone.MIN_INFOS:
        e("too few messages, must at least have " + str(DropZone.MIN_INFOS))
        
    if s.headlines.size() < 3:
        e("too few headlines, should be at least 3")
    
    """
    if typeof(s.param_conditions) != TYPE_DICTIONARY:
        e("invalid param_condition, must be a dictionary")
    for country_num in s.param_conditions:
        if typeof(country_num) != TYPE_INT:
            e("invalid param_condition, index must be a country number")
        if country_num < 1:
            e("invalid param_condition, index must be a country number starting from 1")
        if country_num > s.num_countries:
            e("invalid param_condition, index is " + str(country_num) + " but scenario only uses " + str(s.num_countries) + " countries")
        
        var country_conds = s.param_conditions[country_num]
        if typeof(country_conds) != TYPE_ARRAY:
            e("invalid param_condition at index " + str(country_num) + ", value must be an array")
        for i in range(country_conds.size()):
            var cond = country_conds[i]
            if typeof(cond) != TYPE_ARRAY:
                e("invalid param_condition at index " + str(country_num) + ", condition " + str(i) + "; value must be an array of arrays")
            if cond.size() != 3:
                e("invalid param_condition at index " + str(country_num) + ", condition " + str(i) + "; array must have 3 values")
            
            if not is_valid_param_name(world, cond[0]):
                e("invalid param_condition at index " + str(country_num) + ", condition " + str(i) + "; first value must be valid param, was " + str(cond[0]))
            if cond[1] != Scenario.Op.GREATER and cond[1] != Scenario.Op.LESS:
                e("invalid param_condition at index " + str(country_num) + ", condition " + str(i) + "; second value must be enum LESS or GREATER, was " + str(cond[1]))
            if cond[2] < -1 or cond[2] > 1:
                e("invalid param_condition at index " + str(country_num) + ", condition " + str(i) + "; third value must be between -1 and 1, was " + str(cond[1]))
    
    if typeof(s.relation_conditions) != TYPE_ARRAY:
        e("invalid relation_conditions, must be an Array")
    for i in range(s.relation_conditions.size()):
        var cond = s.relation_conditions[i]
        if typeof(cond[0]) != TYPE_INT or typeof(cond[1]) != TYPE_INT:
            e("invalid relation_conditions at index " + str(i) + ", first two values must be a country number")
        if cond[0] < 1 or cond[1] < 1:
            e("invalid relation_conditions at index " + str(i) + ", first two values must be a country number starting from 1")
        if cond[0] > s.num_countries or cond[1] > s.num_countries:
            e("invalid relation_conditions at index " + str(i) + ", first two values are " + str(cond[0]) + " and " + str(cond[1]) + " but scenario only uses " + str(s.num_countries) + " countries")
        if cond[2] != Scenario.Op.GREATER and cond[2] != Scenario.Op.LESS:
            e("invalid relation_conditions at index " + str(i) + ", third value must be enum value LESS or GREATER, was " + str(cond[2]))
        if (typeof(cond[3]) != TYPE_REAL and typeof(cond[3]) != TYPE_INT) or cond[3] < -1 or cond[3] > 1:
            e("invalid relation_conditions at index " + str(i) + ", fourth value must be float between -1 and 1")
    """

    for i in range(s.messages.size()):
        var m = s.messages[i]
        if m.type != Message.NOTE and m.type != Message.PHAX and m.type != Message.TWEET:
            e("invalid message at index " + str(i) + ", type must be enum value NOTE, PHAX or TWEET, was " + str(m.type))
        if typeof(m.headlines) != TYPE_ARRAY:
            e("invalid message at index " + str(i) + ", headlines must be array, was " + str(m.headlines))
        for o in range(m.headlines.size()):
            var h = m.headlines[o]
            if h < 0:
                e("invalid message at index " + str(i) + ", headline at index " + str(o) + " must be greater or equal than 0")
            if h >= s.headlines.size():
                e("invalid message at index " + str(i) + ", headline at index " + str(o) + " is " + str(h) + " but there are only " + str(s.headlines.size()) + " headlines specified")
        if (typeof(m.arrival_time) != TYPE_REAL and typeof(m.arrival_time) != TYPE_INT) or m.arrival_time < 0 or m.arrival_time > 1:
            e("invalid message at index " + str(i) + ", arrival_time must be float between -1 and 1")
            
    for i in range(s.headlines.size()):
        var h = s.headlines[i]
        if typeof(h.params) != TYPE_DICTIONARY:
            e("invalid headline at index " + str(i) + ", params must be dictionary, was " + str(h.params))
        for param_name in h.params:
            if !is_valid_param_name(world, param_name):
                e("invalid headline at index " + str(i) + ", invalid param \"" + param_name + "\" found")
            var param_value = h.params[param_name]
            if (typeof(param_value) != TYPE_REAL and typeof(param_value) != TYPE_INT) or param_value < -1 or param_value > 1:
                e("invalid headline at index " + str(i) + ", param \"" + param_name + "\" must be value between -1 and 1")
        if (typeof(h.drama) != TYPE_REAL and typeof(h.drama) != TYPE_INT) or h.drama < 0 or h.drama > 1:
            e("invalid headline at index " + str(i) + ", drama must be value between 0 and 1")
        for o in range(h.relations.size()):
            var rel = h.relations[o]
            if typeof(rel) != TYPE_ARRAY or rel.size() != 3:
                e("invalid headline at index " + str(i) + ", relation at index " + str(o) + " must be an array of three values")
            if typeof(rel) != TYPE_ARRAY or rel.size() != 3:
                e("invalid headline at index " + str(i) + ", relation at index " + str(o) + " must be an array of three values")
            if typeof(rel[0]) != TYPE_INT or typeof(rel[1]) != TYPE_INT:
                e("invalid headline at index " + str(i) + ", relation at index " + str(o) + "; first two values must be a country number")
            if rel[0] < 1 or rel[1] < 1:
                e("invalid headline at index " + str(i) + ", relation at index " + str(o) + "; first two values must be a country number starting from 1")
            if rel[0] > s.num_countries or rel[1] > s.num_countries:
                e("invalid headline at index " + str(i) + ", relation at index " + str(o) + "; first two values are " + str(rel[0]) + " and " + str(rel[1]) + " but scenario only uses " + str(s.num_countries) + " countries")
            if (typeof(rel[2]) != TYPE_REAL and typeof(rel[2]) != TYPE_INT) or rel[2] < -1 or rel[2] > 1:
                e("invalid headline at index " + str(i) + ", relation at index " + str(o) + "; third value must be value between -1 and 1")

func second_check(world, s):
    return
    
    for i in range(s.scenario_conditions.size()):
        var cond = s.scenario_conditions[i]
        if !names.has(cond):
            print("Error with scenario \"" + s.name + "\" at scenario_conditions index " + str(i) + ": assumes existence of scenario with name \"" + cond + "\", but it does not seem to exist!")
        for scenario in world.scenarioManager.scenarios:
            if scenario.name == cond:
                if scenario.num_countries != s.num_countries:
                    print("Error with scenario \"" + s.name + "\" at scenario_conditions index " + str(i) + ": has different num_countries than \"" + scenario.name + "\"!")
        
        
func is_valid_param_name(world, name):
    var valid_param = false
    for param in world.params:
        if param.name == name:
            valid_param = true
    return valid_param

func e(msg):
    print("#   " + msg)
