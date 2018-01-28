extends Control

const timeSlot = 2.5
var isRunning = false
var timeYet = 0
var currentSlot = -1
var world
var doneScenarios = []

const DropZone = preload("res://scripts/DropZone.gd")

var Airmail
var DraggableHolder
var Label


func _ready():
    Airmail = get_node("/root/Main/Draggables/Airmail")
    DraggableHolder = get_node("ColorRect/DraggableHolder")
    Label = get_node("ColorRect/Label")
    
func _process(delta):
    if not isRunning:
        return

    timeYet += delta
    if timeYet >= timeSlot:
        timeYet -= timeSlot
        currentSlot += 1
        
        for c in DraggableHolder.get_children():
            c.queue_free()
        
        if (currentSlot >= Airmail.handIns.size()):
            isRunning = false
            get_node("/root/Main/DayEndScreen").visible = false # TODO animate fade out
            world.next_day()
        else:
            var draggable = Airmail.handIns[currentSlot]
  
            DraggableHolder.add_child(draggable)
            draggable.rect_position = Vector2(-draggable.rect_size.x / 2, -draggable.rect_size.y / 2)
            
            var labelStr
            
            if draggable_is_valid(draggable):
                var scenario = draggable.selected_headline.scenario_name
                if (doneScenarios.has(scenario)):
                    labelStr = "Redundant Article!"
                else:
                    doneScenarios.append(scenario)
                    var rating = round(world.broadcast_headline(draggable.selected_headline))
                    labelStr = "Readers "
                    if rating > 0:
                        labelStr += "+"
                    labelStr += str(rating)
            else:
                labelStr = "..."
            
            Label.set_text(labelStr)

func get_rating(draggable):
    if self is DropZone and self.selected_headline != null:
        return 0
    else:
        return randi(10)

func draggable_is_valid(draggable):
    return draggable is DropZone and draggable.selected_headline != null

func _on_Main_day_ended(world):
    isRunning = true
    timeYet = 0
    currentSlot = -1
    self.world = world
    doneScenarios = []

    get_node("/root/Main/DayEndScreen").visible = true # TODO animate fade in

    world.cap_values()
    