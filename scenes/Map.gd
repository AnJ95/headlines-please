extends "res://scripts/Draggable.gd"

onready var twoState = $TwoStateDraggable
onready var country_infos = $country_infos

onready var audio_stream_player_in = get_node("AudioStreamPlayerIn")
onready var audio_stream_player_out = get_node("AudioStreamPlayerOut")

var CountryInfo = preload("res://scenes/CountryInfo.tscn")

# from Draggable
func move_drag():
    twoState.while_moving()

# from Draggable
func stop_drag():
    if twoState.after_moving():
        audio_stream_player_in.play()
    else:
        audio_stream_player_out.play()

# from Draggable
func can_drag_now():
    return not twoState.is_animating()
    
func update(countries):
#    for country in countries:
#        get_node("Country" + country.name).update(country)
    pass

func on_game_started(world):
    for country in world.countries:
        var country_info = CountryInfo.instance()
        country_infos.add_child(country_info)
        country_info.init(country, world.params)
        
