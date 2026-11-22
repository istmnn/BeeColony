extends CanvasLayer
@export var bee_shop_items: Array[ShopItem] = [
	preload("res://Ressources/ShopItems/Bees/NormalBeeShop.tres")
]
@export var room_shop_items: Array[ShopItem] = [
	preload("res://Ressources/ShopItems/Rooms/HoneyRoom1.tres"),
	
]
const MAX_SPAWNED_ITEMS: int = 5
@export var item_slot_scene: PackedScene
@export var item_container: Node
signal room_selected(room_data: RoomType)

# Called when the node enters the scene tree for the first time.
func _ready():
	spawn_shop_Item(bee_shop_items)
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func spawn_shop_Item(shop_items: Array[ShopItem]):
	for child in item_container.get_children():
		child.queue_free()
	var spawn_count: int = mini(shop_items.size(), MAX_SPAWNED_ITEMS)
	for i in range(spawn_count):
		var item_data: ShopItem = shop_items[i]
		if item_data == null:
			continue
		var slot := item_slot_scene.instantiate()
		slot.assignShopItem(item_data);
		slot.roomItem_clicked.connect(_on_roomItem_clicked)
		item_container.add_child(slot)	
			
	pass
func _on_roomItem_clicked(room_data: RoomType, shopItem : ShopItem) -> void:
	room_selected.emit(room_data, shopItem)


func _on_bienen_pressed():
	spawn_shop_Item(bee_shop_items)
	pass # Replace with function body.


func _on_räume_pressed():
	spawn_shop_Item(room_shop_items)
	pass # Replace with function body.
