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
	
func nightStarted() -> void:
	$Background.modulate = Color(0.35, 0.4, 0.65, 1.0)
	for bee in $BeeManger.allBees:
		if bee.sleeping:
			continue
		for room in $Rooms.get_children():
			if room.roomType is SleepRoom and room.roomType.usedBeds < room.roomType.bedAmount:
				room.roomType.usedBeds += 1
				bee.sleep(room)
				break
		if !bee.sleeping:
			bee.happiness -= 25
func dayStarted():
	$Background.modulate = Color.WHITE
	for room in $Rooms.get_children():
		if room.roomType is SleepRoom:
			room.roomType.usedBeds = 0
	pass
