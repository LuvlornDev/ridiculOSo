extends Control


@onready var welcome = $Installer/Welcome
@onready var terms = $Installer/TermsAndConditions
@onready var ad = $Installer/Ad
@onready var privacy = $Installer/PrivacyPolicy
@onready var ad2 = $Installer/Ad2
@onready var binding = $Installer/BindingPolicy
@onready var ad3 = $Installer/Ad3
@onready var ad4 = $Installer/Ad4
@onready var captcha1 = $Installer/Captcha1
@onready var download = $Installer/Download

@onready var progress_bar = $Installer/Download/ProgressBar
@onready var downloading_label = $Installer/Download/downloading
@onready var downloading2_label = $Installer/Download/downloading2

@onready var close_button = $Installer/TextureRect/X
@onready var close_button2 = $Installer/TextureRect/X2
@onready var close_button3 = $Installer/TextureRect/X3


var downloading := false
var text_pages := []


func _ready():

	show_page(welcome)

	welcome.get_node("Button").pressed.connect(_on_welcome_continue)

	terms.get_node("Button").pressed.connect(_on_terms_accept)
	terms.get_node("Button2").pressed.connect(_on_terms_deny)

	ad.get_node("Button").pressed.connect(_on_ad_accept)
	ad.get_node("Button2").pressed.connect(_on_ad_deny)

	privacy.get_node("Button").pressed.connect(_on_privacy_accept)
	privacy.get_node("Button2").pressed.connect(_on_privacy_deny)

	ad2.get_node("Button").pressed.connect(_on_ad2_accept)
	ad2.get_node("Button2").pressed.connect(_on_ad2_deny)

	binding.get_node("Button").pressed.connect(_on_binding_accept)
	binding.get_node("Button2").pressed.connect(_on_binding_deny)

	ad3.get_node("Button").pressed.connect(_on_ad3_accept)
	ad3.get_node("Button2").pressed.connect(_on_ad3_deny)

	ad4.get_node("Button").pressed.connect(_on_ad4_accept)
	ad4.get_node("Button2").pressed.connect(_on_ad4_deny)

	captcha1.get_node("Button").pressed.connect(_on_captcha1_continue)

	close_button.pressed.connect(_on_close)
	close_button2.pressed.connect(_on_close)
	close_button3.pressed.connect(_on_close)

	text_pages = [
		terms,
		privacy,
		binding
	]
	
	for page in text_pages:
		setup_text_page(page)
	
	progress_bar.value = 0
	downloading_label.show()
	downloading2_label.hide()


func show_page(page):

	welcome.hide()
	terms.hide()
	ad.hide()
	privacy.hide()
	ad2.hide()
	binding.hide()
	ad3.hide()
	ad4.hide()
	captcha1.hide()
	download.hide()

	page.show()

	if page in text_pages:
		reset_text_page(page)

	if page == download:
		start_download()


func setup_text_page(page):

	var scroll_container = page.get_node("ScrollContainer")
	var scrollbar = scroll_container.get_v_scroll_bar()

	scrollbar.mouse_filter = Control.MOUSE_FILTER_IGNORE

	var accept_button = page.get_node("Button")
	accept_button.disabled = true


func reset_text_page(page):

	var scroll_container = page.get_node("ScrollContainer")
	var accept_button = page.get_node("Button")

	scroll_container.scroll_vertical = 0
	accept_button.disabled = true

func check_text_page_bottom(page):

	var scroll_container = page.get_node("ScrollContainer")
	var accept_button = page.get_node("Button")

	var scrollbar = scroll_container.get_v_scroll_bar()

	var current = scrollbar.value
	var maximum = scrollbar.max_value
	var page_size = scrollbar.page

	if current + page_size >= maximum - 2:
		accept_button.disabled = false

func _on_welcome_continue():

	show_page(terms)


func _on_terms_accept():

	show_page(ad)


func _on_terms_deny():

	show_page(welcome)


func _on_ad_accept():

	show_page(welcome)


func _on_ad_deny():

	show_page(privacy)


func _on_privacy_accept():

	show_page(ad2)


func _on_privacy_deny():

	show_page(welcome)


func _on_ad2_accept():

	show_page(welcome)


func _on_ad2_deny():

	show_page(binding)


func _on_binding_accept():

	show_page(ad3)


func _on_binding_deny():

	show_page(welcome)


func _on_ad3_accept():

	show_page(welcome)


func _on_ad3_deny():

	show_page(ad4)


func _on_ad4_accept():

	show_page(welcome)


func _on_ad4_deny():

	show_page(captcha1)


func _on_captcha1_continue():

	show_page(download)


func start_download():

	progress_bar.value = 0

	downloading_label.show()
	downloading2_label.hide()

	downloading = true

func _process(delta):

	for page in text_pages:
		if page.visible:
			check_text_page_bottom(page)

	if not downloading:
		return

	progress_bar.value += 20.0 * delta

	if progress_bar.value >= 100:
		progress_bar.value = 100
		downloading = false

		downloading_label.hide()
		downloading2_label.show()


func _on_close():
	get_tree().change_scene_to_file("res://os.tscn")
