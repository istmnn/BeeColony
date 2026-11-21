extends TextureButton
@export var shopItem : ShopItem;


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func assignShopItem(newItem : ShopItem):
	shopItem = newItem

	$Price.text = str(shopItem.price)
	$Icon.texture = shopItem.icon
	$Item.texture = shopItem.item
	
func buy():
	shopItem.buy(get_parent());


func _on_pressed():
	buy()
	pass # Replace with function body.
