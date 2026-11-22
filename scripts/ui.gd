extends CanvasLayer
var shop_scene = preload("res://scenes/shop.tscn")
var active_shop: CanvasLayer = null
var shop_visible : bool = false
signal enterBuildModeSignal(room_data: RoomType)
signal beeSpawned(bee: Bee)

# Called when the node enters the scene tree for the first time.
func _ready():

	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$Control/Honig/Label.text = str(Global.get_amount(Global.Ressources.HONEY))
	$Control/Nektar/Label.text = str(Global.get_amount(Global.Ressources.NEKTAR))
	$Control/Wachs/Label.text = str(Global.get_amount(Global.Ressources.WAX))
	pass


func _on_texture_button_toggled(toggled_on):
	
	pass # Replace with function body.

func open_shop() -> void:
	if active_shop != null and is_instance_valid(active_shop):
		active_shop.visible = true
		return

	var instance := shop_scene.instantiate()
	instance.room_selected.connect(enterBuildMode)
	instance.beeBought.connect(beeSpawn)
	active_shop = instance as CanvasLayer
	add_child(instance)

func close_shop() -> void:
	if active_shop != null and is_instance_valid(active_shop):
		active_shop.queue_free()
		active_shop = null

func _on_texture_button_pressed():
	if(shop_visible):
		close_shop()
	if(!shop_visible):
		open_shop()
	shop_visible = not shop_visible
	pass # Replace with function body.

func enterBuildMode(room_data: RoomType, shop_item: ShopItem):
	enterBuildModeSignal.emit(room_data, shop_item)
	pass

func beeSpawn(bee:Bee):
	beeSpawned.emit(bee)
