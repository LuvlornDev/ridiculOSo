extends Label

var current_number: int = 0
@onready var timer: Timer = $Timer


@onready var canvas_layer_2: CanvasLayer = $"../CanvasLayer2"
@onready var canvas_layer_3: CanvasLayer = $"../CanvasLayer3"
@onready var CenterContainer_3: CenterContainer = $"../CenterContainer3"

func _ready() -> void:
	text = str(current_number)

func _on_timer_timeout() -> void:
	current_number += 1
	text = str(current_number)
	
	if current_number == 12:
		visible = !visible  
		canvas_layer_2.visible = !canvas_layer_2.visible
		canvas_layer_3.visible = !canvas_layer_3.visible
		CenterContainer_3.visible = !CenterContainer_3.visible
		
