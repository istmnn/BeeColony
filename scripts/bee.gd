class_name Bee
extends Node2D
@export var move_speed: float;
@export var idle: bool;
@onready var sprite : Sprite2D = $BeeSprite
@export var sprite_image: Texture2D;
@export var beeType : BeeType;


# Called when the node enters the scene tree for the first time.
func _ready():
	idle = true;
	sprite.texture = sprite_image
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func assignBeeType(newType):
	move_speed = newType.move_speed
	$BeeSprite.texture = newType.texture 
	pass
