extends Node2D
class_name Room
@export var adjecentRooms: Array[Room] = []
@export var roomType : RoomType;
@export var assigned : bool = false
signal entered(room: Room)
signal exited(room: Room)
signal clicked(room: Room)
@onready var area: Area2D = $Area2D

# Called when the node enters the scene tree for the first time.
func _ready():
	setRoomType(roomType)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(roomType != null):	roomType._process(delta)
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
	pass # Replace with function body.
	
func reset_texture() -> void:
	$TextureRect.texture = null

func set_texture(texture: Texture2D):
	$TextureRect.texture = texture

func valid_to_build()-> bool:
	for room in adjecentRooms:
		if(room.assigned): return true
	return false

func is_mouse_over_area() -> bool:
	if area == null or not is_instance_valid(area):
		return false

	var space_state := area.get_world_2d().direct_space_state
	var query := PhysicsPointQueryParameters2D.new()
	query.position = area.get_global_mouse_position()
	query.collide_with_areas = true
	query.collide_with_bodies = false
	query.collision_mask = area.collision_layer

	var results := space_state.intersect_point(query)
	for hit in results:
		if hit.get("collider") == area:
			return true

	return false

func canBeAssigned() -> bool:
	if(roomType.slots == 0): return false
	return (roomType.slots > roomType.filledSlots && assigned)

func addBee(bee: Bee):
	roomType.addBee(bee)
	
func removeBee(bee: Bee):
	roomType.removeBee(bee)
