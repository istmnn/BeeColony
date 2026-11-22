extends Button
const MAIN_SCENE_PATH := "res://scenes/main.tscn"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_pressed():
	var err := get_tree().change_scene_to_file(MAIN_SCENE_PATH)
	if err != OK:
		push_error("Konnte Hauptszene nicht laden. Fehlercode: %s" % err)
