extends "res://scripts/model/Scenario.gd"

func _init():
    name = "Cancer progress"
    num_countries = 1
    init_headlines()
    init_messages()

func get_propability(world, countries):
    return randf() < 0.05

#TODO set an effect for each Headline

func init_headlines():
    h("Institute of Medical Studies might just have found a way to treat cancer!", 0.4, {
        "science" : 0.3
    })
    h("How jellyfishes immune cells help treat cancer", 0.3, {
        "science" : 0.5
    })
    h("Controversial gene technology used in cancer research", 0.4, {
        "science" : -0.2,
        "progress" : -0.2
    })
    h("Could jellyfishes genome be the key to cancer immunity and immortality?", 0.7, {
        "science" : 0.6,
        "progress" : 0.2
    })



func init_messages():
    m(Message.NOTE, [0], "Institute of Medical Studies published new discoveries on cancer")
    m(Message.NOTE, [1], "Lymphatic cells of a jellyfish heavily contributed to research on cancer")
    m(Message.PHAX, [0, 1], "Institute of Medical Studies apparently used jellyfishes immune cells to treat cancer")
    m(Message.TWEET, [2], "playing god will make us crash down one day #stopgenetechnology")
    m(Message.TWEET, [3], "long live the #jellyfish #immortalityherewego!")
