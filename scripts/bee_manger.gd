extends Node2D
var allBees : Array[Bee]
var draggedBee: Bee = null

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(draggedBee != null):
		draggedBee.move_speed = 0
		draggedBee.global_position = get_global_mouse_position()
	pass


func _on_ui_bee_spawned(bee: Bee):
	allBees.append(bee)
	bee.drag_started.connect(dragBee)
	bee.drag_ended.connect(assignbee)
	pass # Replace with function body.

func dragBee(bee: Bee):
	draggedBee = bee
	pass
	
func assignbee(bee: Bee, position : Vector2):
	draggedBee.move_speed = draggedBee.beeType.move_speed
	draggedBee = null
	pass
