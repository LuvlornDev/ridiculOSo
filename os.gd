extends Control



func _ready() -> void:
	pass # Replace with function body.



func _process(delta: float) -> void:
	pass


func _on_button_pressed() -> void:	
	$CanvasLayer2.visible = !$CanvasLayer2.visible


func _on_button_pressed_chocopirata() -> void:
	get_tree().change_scene_to_file("res://chocopirata.tscn")


func _on_button_pressed_browse() -> void:
	get_tree().change_scene_to_file("res://browser.tscn")

func _on_button_pressed_emu() -> void:
	get_tree().change_scene_to_file("res://emumango.tscn")
