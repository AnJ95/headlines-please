extends Control

const timeSlot = 2.5
var isRunning = false
var timeYet = 0
var currentSlot = -1
var world
var doneScenarios = []

const DropZone = preload("res://scripts/DropZone.gd")

onready var Airmail = get_node("/root/Main/Draggables/Airmail")
onready var DraggableHolder = get_node("ColorRect/DraggableHolder")
onready var Label = get_node("ColorRect/Label")
onready var Heading = get_node("ColorRect/Heading")
    
func _process(delta):
    if not isRunning:
        return

    timeYet += delta
    if timeYet >= timeSlot:
        timeYet -= timeSlot
        currentSlot += 1
        
        for c in DraggableHolder.get_children():
            c.queue_free()
        
        if (currentSlot >= Airmail.contained_draggables.size()):
            isRunning = false
            self.visible = false # TODO animate fade out
            world.next_day()
        else:
            var draggable = Airmail.contained_draggables[currentSlot]
  
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
    
    Heading.set_text("Day " + str(world.day) + " over!")

    self.visible = true # TODO animate fade in

    world.cap_values()
    