extends Control

func update(country):
    get_node("lblPop").set_text(str(round(country.inhabitants)) + "M")
    get_node("lblReaders").set_text(str(round(country.inhabitants * country.readers)) + "M")
    #get_node("Economy").update(country.params["economy"])
    #get_node("Satisfaction").update(country.params["satisfaction"])
    #get_node("Bias").update(country.params["bias"])
    
    