extends Node2D
@export var move_speed: float;
@export var idle: bool;


# Called when the node enters the scene tree for the first time.
func _ready():
	idle = true;
	move_speed = 80.0
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
