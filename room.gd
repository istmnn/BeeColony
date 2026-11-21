extends Node2D
class_name Room
@export var adjecentRooms: Array[Room] = []
@export var roomType : RoomType;
@export var assigned : bool = false
signal entered(room: Room)
signal exited(room: Room)
signal clicked(room: Room)

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
	assigned = true
	$TextureRect.texture = newType.texture


func _on_area_2d_mouse_entered():
	entered.emit(self)
	pass # Replace with function body.


func _on_area_2d_mouse_exited():
	exited.emit(self)
	pass # Replace with function body.


func _on_area_2d_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		clicked.emit(self)
		print("test")
	pass # Replace with function body.
	
func reset_texture() -> void:
	$TextureRect.texture = null

func set_texture(texture: Texture2D):
	$TextureRect.texture = texture

func valid_to_build()-> bool:
	for room in adjecentRooms:
		if(room.assigned): return true
	return false
	
