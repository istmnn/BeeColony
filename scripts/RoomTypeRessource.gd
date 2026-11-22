extends RoomType
class_name RoomTypeRessource
signal produced(product: Global.Ressources, amount: int, current_stored: int)
@export var product : Global.Ressources
@export var amount_per_cycle: int 
@export var usedProduct : Global.Ressources
@export var usedProductAmount : int
@export var productionSpeed: float
@export var maxStorage : int

var speed: float
var storedAmount = 0 
var _progress: float = 0.0


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if speed <= 0.0 || filledSlots == 0:
		return
	_progress += delta
	while _progress >= speed:
		_progress -= speed
		produce()
	pass
	
func produce():
	if storedAmount >= maxStorage:
		return

	if usedProductAmount > 0 and not _can_consume_input():
		return

	if usedProductAmount > 0:
		_consume_input()

	var space_left = maxStorage - storedAmount
	var added = mini(amount_per_cycle, space_left)
	storedAmount += added
	Global.add_currency(product, added)
	produced.emit(product, added, storedAmount)

	pass
func _can_consume_input() -> bool:
	# Hier an dein eigenes Lager/Global-System anpassen, z. B.:
	return Global.get_amount(usedProduct) >= usedProductAmount
	return true


func _consume_input() -> void:
	# Hier an dein eigenes Lager/Global-System anpassen, z. B.:
	Global.try_spend(usedProduct, usedProductAmount)
	pass
func effect():
	pass

func getWorkSpeed():
	if productionSpeed <= 0.0:
		return 0.0

	var bee_speed: float = 0.0
	for bee in assignedBees:
		if bee != null and is_instance_valid(bee):
			bee_speed += float(bee.workspeed)

	if bee_speed <= 0.0:
		return 0.0

	var effective_time := productionSpeed / bee_speed
	speed = maxf(effective_time, 0.05)
	
	
func addBee(bee: Bee):
	super.addBee(bee)
	getWorkSpeed()
	
func removeBee(bee: Bee):
	super.removeBee(bee)
	getWorkSpeed()
