extends Node
var maxStorage : int = 300
var bedAmount : int = 0

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
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
