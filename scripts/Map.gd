extends "res://scripts/Draggable.gd"

onready var twoState = $TwoStateDraggable
onready var country_infos = $country_infos
onready var country_relations = $country_relations
onready var country_info_dic = {}
onready var country_relation_dic = {}

onready var audio_stream_player_in = get_node("AudioStreamPlayerIn")
onready var audio_stream_player_out = get_node("AudioStreamPlayerOut")
onready var tween = get_node("Tween")

export var map_day_end_position = Vector2(27, 90)

var RelationThread = preload("res://scenes/RelationThread.tscn")
var CountryInfo = preload("res://scenes/CountryInfo.tscn")
var start_position = null

func _ready():
    update_info_modulation()

# from Draggable
func move_drag():
    twoState.while_moving()
    update_info_modulation()

func update_info_modulation():
    var p = twoState.get_progress()
    country_infos.modulate.a = p * p
    country_relations.modulate.a = p * p

# from Draggable
func stop_drag():
    if twoState.after_moving():
        audio_stream_player_in.play()
    else:
        audio_stream_player_out.play()

# from Draggable
func can_drag_now():
    return not twoState.is_animating()
    
func _process(delta):
    if twoState.is_animating:
        update_info_modulation()
        
func update(world):
    for country_name in country_info_dic:
        country_info_dic[country_name].update(world.get_country(country_name))
    for relation_id in country_relation_dic:
        country_relation_dic[relation_id].update(world.relations.get_by_relation_id(relation_id))
    pass

func on_game_started(world):
    for country in world.countries:
        var country_info = CountryInfo.instance()
        country_info_dic[country.name] = country_info
        country_infos.add_child(country_info)
        country_info.init(country, world.params)
        
    var r = world.relations
    for a in world.countries:
        for b in world.countries:
            if not a.name == b.name:
                var rel_id = r.get_relation_id_by_country_ids(r.get_country_id_by_name(a.name), r.get_country_id_by_name(b.name))
                if not country_relation_dic.has(rel_id) and not rel_id == -1:
                    var thread = RelationThread.instance()
                    country_relation_dic[rel_id] = thread
                    country_relations.add_child(thread)
                    thread.init(r.get_by_relation_id(rel_id), country_info_dic[a.name], country_info_dic[b.name])
        

func day_ended(world):
    start_position = rect_position
    twoState.is_animating = true
    tween.interpolate_property(self, "rect_position", rect_position, map_day_end_position, 0.4, Tween.TRANS_QUART, Tween.EASE_IN_OUT)
    tween.start()
    
func day_started(world):
    if start_position != null:
        twoState.is_animating = true
        tween.interpolate_property(self, "rect_position", rect_position, start_position, 0.4, Tween.TRANS_QUART, Tween.EASE_IN_OUT)
        tween.start()


func on_tween_completed( object, key ):
    twoState.is_animating = false
