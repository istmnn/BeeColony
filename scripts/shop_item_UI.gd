extends TextureButton
@export var shopItem : ShopItem;
signal roomItem_clicked(room_data: RoomType)


# Called when the node enters the scene tree for the first time.
func _ready():
	pressed.connect(_on_pressed)
	pass # Replace with function body.

func _on_pressed() -> void:
	if (shopItem != null &&  shopItem is RoomShopItem):
		roomItem_clicked.emit(shopItem.roomType)
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
