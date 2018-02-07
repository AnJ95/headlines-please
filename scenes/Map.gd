extends "res://scripts/Draggable.gd"

onready var twoState = $TwoStateDraggable
onready var country_infos = $country_infos

onready var audio_stream_player_in = get_node("AudioStreamPlayerIn")
onready var audio_stream_player_out = get_node("AudioStreamPlayerOut")
onready var tween = get_node("Tween")

export var map_day_end_position = Vector2(27, 90)

var CountryInfo = preload("res://scenes/CountryInfo.tscn")

var start_position = null

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

func day_ended(world):
    start_position = rect_position
    tween.interpolate_property(self, "rect_position", rect_position, map_day_end_position, 0.4, Tween.TRANS_QUART, Tween.EASE_IN_OUT)
    tween.start()
    
func day_started(world):
    if start_position != null:
        tween.interpolate_property(self, "rect_position", rect_position, start_position, 0.4, Tween.TRANS_QUART, Tween.EASE_IN_OUT)
        tween.start()
