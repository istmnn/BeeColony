extends RoomType
class_name StorageRoom
@export var StorageAmount : int


# Called when the node enters the scene tree for the first time.
func _ready():
	super._ready()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func addBee(bee: Bee):
	super.addBee(bee)#
	Global.maxStorage += StorageAmount
	
	
func removeBee(bee: Bee):
	super.removeBee(bee)
	Global.maxStorage -= StorageAmount
