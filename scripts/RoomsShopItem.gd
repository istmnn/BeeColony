extends ShopItem
class_name RoomShopItem
@export var roomType : RoomType


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func buy(buyer: Node):
	pass

func reduce_currency():
	Global.try_spend(Global.Ressources.WAX, price);
