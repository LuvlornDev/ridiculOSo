extends Label

var current_number: int = 0

@onready var canvas_layer_2: CanvasLayer = $"../../CanvasLayer2"

func _ready() -> void:
	text = str(current_number)


		


func _on_button_pressed() -> void:
	current_number+=1
	text = str(current_number)
	
	if current_number == 41:
		get_tree().change_scene_to_file("res://step3.tscn")
	
	
