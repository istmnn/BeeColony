extends CanvasLayer
@export var shop_items: Array[ShopItem] = [
	preload("res://Ressources/ShopItems/Bees/NormalBeeShop.tres")
]
const MAX_SPAWNED_ITEMS: int = 5
@export var item_slot_scene: PackedScene
@export var item_container: Node

# Called when the node enters the scene tree for the first time.
func _ready():
	spawn_shop_Item()
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func spawn_shop_Item():
	for child in item_container.get_children():
		child.queue_free()
	var spawn_count: int = mini(shop_items.size(), MAX_SPAWNED_ITEMS)
	for i in range(spawn_count):
		var item_data: ShopItem = shop_items[i]
		if item_data == null:
			continue
		var slot := item_slot_scene.instantiate()
		slot.assignShopItem(item_data);
		item_container.add_child(slot)	
			
	pass
