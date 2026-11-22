extends Node2D
class_name Build_Manager

var selected_room: RoomType = null
var is_placing: bool = false
var shop_item : ShopItem
@onready var ghost_preview: TextureRect = $"../GhostPreview"


func readyMethode() -> void:
	for child in $"../Rooms".get_children():
		if child.has_signal("entered"):
			child.entered.connect(room_entered)
		if child.has_signal("exited"):
			child.exited.connect(room_exited)
		if child.has_signal("clicked"):
			child.clicked.connect(room_clicked)
	ghost_preview.mouse_filter = Control.MOUSE_FILTER_IGNORE
	ghost_preview.visible = false
			
	pass
	
func processMethode(_delta: float) -> void:
	if ghost_preview.visible:
		# Zentriert das TextureRect grob am Mauszeiger
		ghost_preview.global_position = get_global_mouse_position() - ghost_preview.size * 0.5

func start_placement(room_data: RoomType) -> void:
	if room_data == null:
		return
		
	end_placement() # Falls schon etwas aktiv war, sauber aufräumen
	selected_room = room_data
	start_ghost(room_data.texture) 
	is_placing = true

func end_placement() -> void:
	is_placing = false
	selected_room = null
	shop_item = null
	stop_ghost()
	
func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		end_placement();

func _on_ui_enter_build_mode_signal(room_data, shopItem: ShopItem):
	start_placement(room_data)
	shop_item = shopItem
	pass # Replace with function body.


func room_entered(room: Room):
	if(is_placing == false || room.assigned || !room.valid_to_build()): return
	room.set_texture(preload("res://assets/Rooms/RoomEmpty.PNG"));
	pass

func room_exited(room: Room):
	if(is_placing == false || room.assigned || !room.valid_to_build()): return
	room.reset_texture()
	pass
	
func room_clicked(room: Room):
	if(is_placing == false || room.assigned || !room.valid_to_build()): return
	room.setRoomType(selected_room);
	shop_item.reduce_currency()
	end_placement()
	pass

func start_ghost(tex: Texture2D) -> void:
	ghost_preview.texture = tex
	ghost_preview.modulate = Color(1.0, 1.0, 1.0, 0.5) # 50 % Transparenz
	ghost_preview.visible = true

func stop_ghost() -> void:
	ghost_preview.visible = false
	ghost_preview.texture = null
