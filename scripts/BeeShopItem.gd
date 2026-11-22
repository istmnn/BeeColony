class_name BeeShopItem
extends ShopItem
signal beeSpawned(bee: Bee)

var bee = preload("res://scenes/bee.tscn")
@export var beeType : BeeType;


func buy(buyer: Node):
	if(Global.get_amount(currency) < price):
		return
	var current_scene := buyer.get_tree().current_scene
	if current_scene == null:
		return false
		
	var new_bee := bee.instantiate()
	current_scene.add_child(new_bee)
	

	if new_bee is Node2D:
		(new_bee as Node2D).global_position = buyer.get_viewport().get_visible_rect().get_center()
	if new_bee is Bee:
		(new_bee as Bee).assignBeeType(beeType)
	beeSpawned.emit(new_bee)
	Global.try_spend(currency,price)
	return false
