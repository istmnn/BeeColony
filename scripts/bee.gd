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
@onready var beeSprite = $BeeSprite


# Called when the node enters the scene tree for the first time.
func _ready():
	idle = true;
	sprite.texture = sprite_image
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(assigned_room != null): move_speed = 0
	elif(beeType != null): move_speed = beeType.move_speed
	pass

func assignBeeType(newType):
	move_speed = newType.move_speed
	statmoveSpeed = newType.move_speed
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
	print("assigned")
	pass
