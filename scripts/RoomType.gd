class_name RoomType
extends Resource
@export var slots : int;
@export var texture : Texture2D;
@export var name : String;
var filledSlots: int
var assignedBees : Array[Bee]

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func produce():
	pass

func effect():
	pass
	
func addBee(bee: Bee):
	assignedBees.append(bee)
	filledSlots += 1
	
func removeBee(bee: Bee):
	assignedBees.erase(bee)
	filledSlots -= 1
