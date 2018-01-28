extends Control

const Message = preload("res://scripts/model/Message.gd")
const TweetScene = preload("res://scenes/Tweet.tscn")

export(Vector2) var tweet_pos
export var max_tweets = 5

var tweets = []

func _on_Main_day_ended(world):
    for t in tweets:
        print(t)
        t.queue_free()

func _on_Main_day_started(world):
    return

func _on_Main_message_arrived(message):
    if message.type == Message.TWITTER:
        add_tweet(message)
    
func add_tweet(message):
    var info_node = TweetScene.instance()
    info_node.init(message)
    add_child(info_node)

    info_node.rect_position = tweet_pos - Vector2(0, info_node.rect_size.y)
    for t in tweets:
        t.rect_position -= Vector2(0, info_node.rect_size.y)        
    tweets.append(info_node)
    while tweets.size() > 5:
        tweets.pop_front().queue_free()
