extends Node
var maxStorage : int = 300
var bedAmount : int = 0
var beeAmount: int = 0
var day_time_scale: float = 60.0
var night_speed_multiplier: float = 2.0
var day_start_hour: int = 6   # 06:00 Uhr
var night_start_hour: int = 18 # 18:00 Uhr
var hours : int
var minutes : int
var is_night = false
var _was_night: bool = false

signal night_started
signal day_started

## Startzeit in Sekunden (6 * 3600 = 06:00:00)
var game_seconds: float = 6.0 * 3600.0

enum Ressources {
	NEKTAR,
	HONEY,
	WAX,
}
var balances: Dictionary = {
	Ressources.NEKTAR: 100,
	Ressources.HONEY: 500,
	Ressources.WAX: 100,
}

func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	time(delta)
	
	pass

func get_amount(currency: Ressources) -> int:
	return balances.get(currency, 0)

func can_afford(currency: Ressources, amount: int) -> bool:
	return get_amount(currency) >= amount

func try_spend(currency: Ressources, amount: int) -> bool:
	if amount < 0 or not can_afford(currency, amount):
		return false
	balances[currency] = get_amount(currency) - amount
	return true

func add_currency(currency: Ressources, amount: int) -> void:
	if amount < 0:
		return
	balances[currency] = get_amount(currency) + amount
	if (balances[currency] > maxStorage ):
		balances[currency] = maxStorage
	
# Called when the node enters the scene tree for the first time.

func time(delta):
	var current_hour := int(game_seconds / 3600.0) % 24
	is_night = current_hour < day_start_hour or current_hour >= night_start_hour

	if is_night and not _was_night:
		night_started.emit()
	elif not is_night and _was_night:
		day_started.emit()

	_was_night = is_night

	var current_scale := day_time_scale
	if is_night:
		current_scale *= night_speed_multiplier

	# 24 Stunden = 86400 Sekunden; fmod sorgt dafür, dass nach 23:59:59 wieder 00:00:00 kommt
	game_seconds = fmod(game_seconds + delta * current_scale, 86400.0)
	var total_sec := int(game_seconds)
	hours = total_sec / 3600
	minutes = (total_sec % 3600) / 60
