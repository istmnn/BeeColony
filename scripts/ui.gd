extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready():

	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$Control/Honig/Label.text = str(Global.get_amount(Global.Ressources.HONEY))
	$Control/Nektar/Label.text = str(Global.get_amount(Global.Ressources.NEKTAR))
	$Control/Wachs/Label.text = str(Global.get_amount(Global.Ressources.WAX))
	pass
