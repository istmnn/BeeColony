extends Node2D
class_name Room
@export var adjecentRooms: Array[Room] = []
@export var roomType : RoomType;
var assigned : bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
	setRoomType(roomType)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func setRoomType(newType: RoomType):
	if(newType == null):
		return
	roomType = newType
	$TextureRect.texture = newType.texture
