extends Control

const Message = preload("res://scripts/model/Message.gd")
const TweetScene = preload("res://scenes/Tweet.tscn")

export(Vector2) var anchor_pos
export var max_tweets = 1

var tweets = []

func _on_Main_day_ended(world):
    for t in tweets:
        print(t)
        t.queue_free()

func _on_Main_day_started(world):
    return

func _on_Main_message_arrived(message):
    if message.type == Message.PHAX:
        add_tweet(message)
    
func add_tweet(message):
    var info_node = TweetScene.instance()
    info_node.init(message)
    add_child(info_node)

    info_node.rect_position = anchor_pos - Vector2(0, info_node.rect_size.y)
    for t in tweets:
        t.rect_position -= Vector2(0, info_node.rect_size.y)        
    tweets.append(info_node)
    while tweets.size() > max_tweets:
        tweets.pop_front().queue_free()
