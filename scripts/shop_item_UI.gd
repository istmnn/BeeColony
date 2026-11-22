extends TextureButton
@export var shopItem : ShopItem;
signal roomItem_clicked(room_data: RoomType)
signal beeSpawned(bee:Bee)


# Called when the node enters the scene tree for the first time.
func _ready():
	pressed.connect(_on_pressed)
	pass # Replace with function body.

func _on_pressed() -> void:
	if (shopItem != null &&  shopItem is RoomShopItem && Global.get_amount(Global.Ressources.WAX) >= shopItem.price):
		roomItem_clicked.emit(shopItem.roomType, shopItem)
	if (shopItem != null &&  shopItem is BeeShopItem && Global.get_amount(Global.Ressources.HONEY) >= shopItem.price):

		shopItem.beeSpawned.connect(spawnBee)	
	buy()
		
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
	
func spawnBee(bee: Bee):
	Global.beeAmount += 1
	beeSpawned.emit(bee)
