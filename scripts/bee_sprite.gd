extends Sprite2D
var move_speed: float;
@export var wander_radius: float = 400.0
@export var hover_amplitude: float = 8.0   
@export var hover_frequency: float = 6.0 
@export var sprite_faces_left: bool = false 
var start_position: Vector2
var target_position: Vector2
var time_passed: float = 0.0
@onready var parent = get_parent();

func _ready() -> void:
	start_position = position
	pick_new_target()
	

func _process(delta: float) -> void:
	move_speed = parent.move_speed
	idle(delta);
	
func idle(delta: float):
	time_passed += delta
	var direction = (target_position - position).normalized()
	position += direction * move_speed * delta
	var hover_offset = cos(time_passed * hover_frequency) * hover_amplitude * hover_frequency * delta
	position.y += hover_offset
	if direction.x != 0:
		if abs(direction.x) > 0.05:
			var moving_left = direction.x < 0.0
			flip_h = moving_left if sprite_faces_left else not moving_left
	if position.distance_to(target_position) < 10.0:
		pick_new_target()
		
func pick_new_target() -> void:
	var random_offset = Vector2(
		randf_range(-wander_radius, wander_radius),
		randf_range(-wander_radius * 0.6, wander_radius * 0.6) # Etwas weniger vertikal als horizontal
	)
	target_position = start_position + random_offset
