extends RoomType
class_name SleepRoom
@export var bedAmount : int
var usedBeds = 0


# Called when the node enters the scene tree for the first time.
func _ready():
	Global.bedAmount += bedAmount
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
