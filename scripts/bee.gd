class_name Bee
extends Node2D
@export var move_speed: float;
@export var idle: bool;
@onready var sprite : Sprite2D = $BeeSprite
@export var sprite_image: Texture2D;
@export var beeType : BeeType;
signal drag_started(worker: Bee)
signal drag_ended(worker: Bee, drop_global_position: Vector2)
var is_dragging: bool = false
var _drag_offset: Vector2 = Vector2.ZERO
var assigned_room: Room = null
var statmoveSpeed : int
var workspeed: float
@onready var beeSprite = $BeeSprite
@export var sleepTime: int
var sleeping: bool = false;
var _wake_hour: int = -1


# Called when the node enters the scene tree for the first time.
func _ready():
	idle = true;
	sprite.texture = sprite_image
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if is_dragging:
		return
	if sleeping and _is_wake_time_reached():
		wakeUp()
	if (assigned_room != null or sleeping):
		move_speed = 0.0


func assignBeeType(newType):
	move_speed = newType.move_speed
	statmoveSpeed = newType.move_speed
	workspeed = newType.workspeed
	sleepTime = newType.sleepTime
	$BeeSprite.texture = newType.texture 
	pass


func _on_area_2d_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.pressed:
			is_dragging = true
			_drag_offset = global_position - get_global_mouse_position()
			drag_started.emit(self)
	pass # Replace with function body.

func _unhandled_input(event: InputEvent) -> void:
	if not is_dragging:
		return

	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and not event.pressed:
		is_dragging = false
		drag_ended.emit(self, get_global_mouse_position())

func assignRoom(room : Room):
	
	assigned_room = room
	move_speed = 0
	room.addBee(self)
	pass
	
func removeRoom():
	if(assigned_room != null):
		assigned_room.removeBee(self)
	assigned_room = null	
	move_speed = statmoveSpeed

func sleep(room: Room):
	print("test")
	sleeping = true
	_wake_hour = (Global.hours + sleepTime) % 24
#	goToRoom(room)
	pass

func wakeUp():
	print("wach")
	sleeping = false
	_wake_hour = -1
	if statmoveSpeed > 0:
		move_speed = float(statmoveSpeed)
	if assigned_room != null:
		pass
		#goToRoom(assigned_room)
	else:
		idle = true

	
func _is_wake_time_reached() -> bool:
	
	if _wake_hour < 0:
		return false
	# Falls die Schlafenszeit über Mitternacht geht (z. B. Einschlafen 22 Uhr, Weckzeit 2 Uhr):
	# Nachts (hours >= 18) warten wir bis zur Weckzeit, tagsüber (hours < 18) sind wir über Mitternacht hinaus.
	if Global.hours >= _wake_hour:
		# Sonderfall: Biene schläft z. B. um 18 Uhr ein und sleepTime = 2 -> Weckzeit 20 Uhr.
		# Um 21 Uhr ist hours >= _wake_hour wahr -> wecken.
		# Sonderfall: Biene schläft um 22 Uhr ein und sleepTime = 4 -> _wake_hour = 2.
		# Um 23 Uhr ist hours (23) >= _wake_hour (2), aber sie soll erst um 2 Uhr aufwachen!
		if _wake_hour < Global.day_start_hour and Global.is_night:
			return false
		return true
	return false
	
