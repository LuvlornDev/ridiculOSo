extends Control


@onready var timer = $Timer


func _ready() -> void:
	pass # Replace with function body.



func _process(delta: float) -> void:
	pass


func _on_button_pressed_boot() -> void:
	timer.start()
	$CenterContainer.visible = !$CenterContainer.visible
	$AnimatedSprite2D.visible = !$AnimatedSprite2D.visible
	$AudioStreamPlayer2D.play()


func _on_timer_timeout() -> void:
	get_tree().change_scene_to_file("res://os.tscn")
