
func format(s, dic):
    var start_index = s.find("{")
    while start_index != -1:
        var stop_index = s.find("}")
        var var_name = s.substring(start_index+1, start_index-1)
        if var_name in dic:
            s.replace(start_index, stop_index, dic[var_name])
        else:
            printerr("entry " + var_name + " not found in dictionary")
        start_index = s.find("{")

