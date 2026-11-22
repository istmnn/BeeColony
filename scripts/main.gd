extends Node2D
@export var build_manager: Build_Manager


func _ready() -> void:
	build_manager.readyMethode()
	pass
func _process(_delta: float) -> void:
	build_manager.processMethode(_delta)
	pass
	
