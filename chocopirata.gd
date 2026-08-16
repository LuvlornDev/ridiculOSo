extends Control

@onready var timer = $Timer


func _ready() -> void:
	pass # Replace with function body.



func _process(delta: float) -> void:
	pass


func _on_button_pressed_close() -> void:
	get_tree().change_scene_to_file("res://os.tscn")


func _on_button_pressed_download() -> void:
	$CenterContainer.visible = !$CenterContainer.visible
	$CanvasLayer2.visible = !$CanvasLayer2.visible
	$CanvasLayer3.visible = !$CanvasLayer3.visible
	$Label.visible = !$Label.visible
	timer.start()
	


func _on_button_pressed_wifi_restore() -> void:
	get_tree().change_scene_to_file("res://wificonnect.tscn")
