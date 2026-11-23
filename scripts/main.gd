extends Node2D
@export var build_manager: Build_Manager


func _ready() -> void:
	build_manager.readyMethode()
	Global.night_started.connect(nightStarted)
	Global.day_started.connect(dayStarted)
	pass
	
func _process(_delta: float) -> void:
	build_manager.processMethode(_delta)
	pass
	
func nightStarted():
	$Background.modulate = Color(0.35, 0.4, 0.65, 1.0)
	pass

func dayStarted():
	$Background.modulate = Color.WHITE
	pass
