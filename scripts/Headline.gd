extends Control



func init(var vecPos, var strHeadline, var clickElem, var clickMethod):
	rect_position = vecPos
	get_node("TextureButton/Label").text = strHeadline
	if clickElem != null:
		get_node("TextureButton").connect("pressed", clickElem, clickMethod, [strHeadline])

