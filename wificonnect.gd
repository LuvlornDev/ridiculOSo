extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_button_pressed_wifi() -> void:
	$CanvasLayer.visible = !$CanvasLayer.visible
	$CenterContainer.visible = !$CenterContainer.visible
	$CanvasLayer2.visible = !$CanvasLayer2.visible
	$CenterContainer2.visible = !$CenterContainer2.visible
	$Label.visible = !$Label.visible
	
