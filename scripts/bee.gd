class_name Bee
extends Node2D

@export var move_speed: float
@export var idle: bool
@onready var sprite: Sprite2D = $BeeSprite
@export var sprite_image: Texture2D
@export var beeType: BeeType
@export var room_spread_radius: float = 70.0

signal drag_started(worker: Bee)
signal drag_ended(worker: Bee, drop_global_position: Vector2)
signal arrived_at_room(room: Room)

var is_dragging: bool = false
var _drag_offset: Vector2 = Vector2.ZERO
var assigned_room: Room = null
var statmoveSpeed: int
var workspeed: float
@onready var beeSprite = $BeeSprite
@export var sleepTime: int
var sleeping: bool = false
var _wake_hour: int = -1

var target_room: Room = null
var _target_position: Vector2 = Vector2.ZERO
var _is_moving_to_room: bool = false
const ROOM_ARRIVAL_THRESHOLD: float = 12.0


# Called when the node enters the scene tree for the first time.
func _ready():
	idle = true
	sprite.texture = sprite_image


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if is_dragging:
		return

	if sleeping and _is_wake_time_reached():
		wakeUp()

	if _is_moving_to_room and target_room != null:
		_process_move_to_room(delta)
		return

	if assigned_room != null or sleeping:
		move_speed = 0.0


func assignBeeType(newType):
	move_speed = newType.move_speed
	statmoveSpeed = newType.move_speed
	workspeed = newType.workspeed
	sleepTime = newType.sleepTime
	$BeeSprite.texture = newType.texture


func _on_area_2d_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.pressed:
			cancel_move_to_room()
			is_dragging = true
			_drag_offset = global_position - get_global_mouse_position()
			drag_started.emit(self)


func _unhandled_input(event: InputEvent) -> void:
	if not is_dragging:
		return

	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and not event.pressed:
		is_dragging = false
		drag_ended.emit(self, get_global_mouse_position())


func assignRoom(room: Room):
	assigned_room = room
	move_speed = 0
	room.addBee(self)


func removeRoom():
	if assigned_room != null:
		assigned_room.removeBee(self)
	assigned_room = null
	move_speed = statmoveSpeed


func sleep(room: Room):
	print("test")
	sleeping = true
	_wake_hour = (Global.hours + sleepTime) % 24
	if room != null:
		move_to_room(room)


func wakeUp():
	print("wach")
	sleeping = false
	_wake_hour = -1
	if statmoveSpeed > 0:
		move_speed = float(statmoveSpeed)
	if assigned_room != null:
		move_to_room(assigned_room)
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


# Ändert assigned_room NICHT – fliegt zu einer leicht versetzten Position im Raum
func move_to_room(room: Room) -> void:
	if room == null:
		return

	target_room = room
	_is_moving_to_room = true
	idle = false

	var random_offset = Vector2(
		randf_range(-room_spread_radius, room_spread_radius),
		randf_range(-room_spread_radius * 0.5, room_spread_radius * 0.5)
	)
	_target_position = room.global_position + random_offset

	var speed: float = float(statmoveSpeed) if statmoveSpeed > 0 else move_speed
	if speed <= 0.0:
		speed = 150.0
	move_speed = speed


func cancel_move_to_room() -> void:
	_is_moving_to_room = false
	target_room = null


func _process_move_to_room(delta: float) -> void:
	var to_goal: Vector2 = _target_position - global_position
	var distance: float = to_goal.length()

	if sprite != null and abs(to_goal.x) > 0.05:
		var moving_left: bool = to_goal.x < 0.0
		sprite.flip_h = moving_left if sprite.sprite_faces_left else not moving_left

	if sprite != null:
		sprite.time_passed += delta
		sprite.position.y += cos(sprite.time_passed * sprite.hover_frequency) * sprite.hover_amplitude * sprite.hover_frequency * delta

	var step: float = move_speed * delta
	if distance <= ROOM_ARRIVAL_THRESHOLD or step >= distance:
		global_position = _target_position
		var reached_room: Room = target_room
		_is_moving_to_room = false
		target_room = null
		move_speed = 0.0

		if sprite != null:
			sprite.position = Vector2.ZERO

		arrived_at_room.emit(reached_room)
		return

	global_position += to_goal.normalized() * step
