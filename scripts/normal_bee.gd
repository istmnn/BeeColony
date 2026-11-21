extends Node2D
@onready var bee  = get_parent();
var move_speed = 80;


# Called when the node enters the scene tree for the first time.
func _ready():
	bee.move_speed = move_speed;
	bee.sprite_image = load("res://assets/bees/NormalBee.PNG");
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
