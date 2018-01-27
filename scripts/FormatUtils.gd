
static func format(s, dic):
    var start_index = s.find("{")
    while start_index != -1:
        var stop_index = s.find("}")
        var var_name = s.substr(start_index+1, stop_index - start_index - 1)
        if var_name in dic:
            s.erase(start_index, stop_index - start_index + 1)
            s = s.insert(start_index, dic[var_name])
        else:
            printerr("entry " + var_name + " not found in dictionary")
            return
        start_index = s.find("{")
    return s

