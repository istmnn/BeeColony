extends Node2D
@export var move_speed: float;
@export var idle: bool;
@onready var sprite : Sprite2D = $BeeSprite
@export var sprite_image: Texture2D;


# Called when the node enters the scene tree for the first time.
func _ready():
	idle = true;
	sprite.texture = sprite_image
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
