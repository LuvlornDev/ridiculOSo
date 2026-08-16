extends Control


@onready var macondoole_page = $Macondoole
@onready var pirate_website = $SanAndresito
@onready var dino_page = $Dino

@onready var search_box = $Macondoole/LineEdit
@onready var search_button = $Macondoole/Button
@onready var close_tab_button = $Dino/GoBack


func _ready():
	show_macondoole()
	search_button.pressed.connect(_on_search)
	close_tab_button.pressed.connect(_on_close_dino)
	search_box.text_submitted.connect(_on_search)


func _on_search(_text = ""):
	var search = search_box.text.strip_edges().to_lower()
	if search == "https://www.sanandresitopaquetesdesoftwarecompletamentelegal100realnofake.xyz":
		show_pirate_website()
	else:
		show_dino()

func show_macondoole():
	macondoole_page.show()
	pirate_website.hide()
	dino_page.hide()

func show_pirate_website():
	macondoole_page.hide()
	pirate_website.show()
	dino_page.hide()

func show_dino():
	macondoole_page.hide()
	pirate_website.hide()
	dino_page.show()

func _on_close_dino():
	show_macondoole()
	search_box.clear()


func _on_button_pressed_close_arepa() -> void:
	get_tree().change_scene_to_file("res://os.tscn")
