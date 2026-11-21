class_name ShopItem
extends Resource

@export var title: String = "Unbenanntes Item"
@export var price: int = 50
@export var icon: Texture2D
@export var item: Texture2D
@export var currency : Global.Ressources


# Wird in Unterklassen überschrieben. Gibt true zurück, wenn der Kauf geklappt hat.
func buy(buyer: Node) :
	push_warning("buy() ist für '%s' nicht implementiert." % title)
	return false

func reduce_currency():
	pass
