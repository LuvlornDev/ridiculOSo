extends Label

var current_number: int = 0

@onready var canvas_layer_2: CanvasLayer = $"../../CanvasLayer2"

func _ready() -> void:
	text = str(current_number)


		


func _on_button_pressed_cl() -> void:
	current_number+=1
	text = str(current_number)
	
	if current_number == 67:
		get_tree().change_scene_to_file("res://wificonnect2.tscn")
	
	
