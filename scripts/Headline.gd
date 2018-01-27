extends Control

func init(var headline, var vecPos, var clickElem, var clickMethod):
	rect_position = vecPos
	get_node("TextureButton/Label").text = headline.text
	if clickElem != null:
		get_node("TextureButton").connect("pressed", clickElem, clickMethod, [headline])

