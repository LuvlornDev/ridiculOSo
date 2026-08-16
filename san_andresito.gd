extends Control


@onready var download_button = $download
@onready var progress_bar = $ProgressBar
@onready var errorlabel = $ErrorLabel
@onready var successlabel = $Success
@onready var resumebtn = $Resume
@onready var ads = $Ads


var downloading := false
var ram_error := false

const START_PROGRESS := 5.0
const NORMAL_SPEED := 1.5
const DEPLETION_SPEED := 0.
const MAX_ADS := 8

var open_ads := 0

var ad_spawn_timer := 0.0
var next_spawn_time := 1.0


func _ready():
	progress_bar.hide()
	errorlabel.hide()
	successlabel.hide()
	resumebtn.hide()

	download_button.pressed.connect(start_download)
	resumebtn.pressed.connect(resume_download)

	for ad in ads.get_children():
		ad.hide()

		var close_button = ad.get_node("close")
		close_button.pressed.connect(_on_ad_closed.bind(ad))


func start_download():
	download_button.hide()

	progress_bar.show()
	progress_bar.value = START_PROGRESS

	errorlabel.hide()
	successlabel.hide()
	resumebtn.hide()

	downloading = true
	ram_error = false

	open_ads = 0

	ad_spawn_timer = 0.0
	set_next_spawn_time()

func _process(delta):
	if not downloading:
		return

	if ram_error:
		progress_bar.value -= DEPLETION_SPEED * delta
		progress_bar.value = max(progress_bar.value, 0.0)
		return

	var speed_multiplier = get_speed_multiplier()

	progress_bar.value += NORMAL_SPEED * speed_multiplier * delta
	progress_bar.value = min(progress_bar.value, 100.0)

	ad_spawn_timer += delta

	if ad_spawn_timer >= next_spawn_time:
		ad_spawn_timer = 0.0
		set_next_spawn_time()
		spawn_ads()

	if progress_bar.value >= 100.0:
		progress_bar.value = 100.0
		downloading = false

		ads.hide()
		successlabel.show()
		successlabel.move_to_front()


func set_next_spawn_time():
	var progress = progress_bar.value / 100.0

	var minimum_time = lerp(1.0, 1.5, progress)
	var maximum_time = lerp(2.2, 3.0, progress)

	next_spawn_time = randf_range(minimum_time, maximum_time)


func spawn_ads():
	if open_ads >= MAX_ADS:
		return

	var amount = 1 if randi() % 2 == 0 else 2
	amount = min(amount, MAX_ADS - open_ads)

	var available_ads = []

	for ad in ads.get_children():
		if not ad.visible:
			available_ads.append(ad)

	available_ads.shuffle()

	for i in range(amount):
		if i >= available_ads.size():
			break

		spawn_one_ad(available_ads[i])


func spawn_one_ad(ad):
	if open_ads >= MAX_ADS:
		return

	if ad.visible:
		return

	randomize_ad_position(ad)
	ad.show()

	open_ads += 1

	if open_ads >= MAX_ADS:
		trigger_ram_error()


func randomize_ad_position(ad):
	var area_size = ads.size
	var ad_size = ad.size

	var max_x = max(0.0, area_size.x - ad_size.x)
	var max_y = max(0.0, area_size.y - ad_size.y)

	var random_x = randf_range(0.0, max_x)
	var random_y = randf_range(0.0, max_y)

	ad.position = Vector2(random_x, random_y)


func _on_ad_closed(ad):
	if not ad.visible:
		return

	ad.hide()

	open_ads -= 1
	open_ads = max(open_ads, 0)

	if ram_error and open_ads == 0:
		downloading = false

		errorlabel.show()
		errorlabel.move_to_front()

		resumebtn.show()
		resumebtn.move_to_front()


func get_speed_multiplier() -> float:
	match open_ads:
		0:
			return 1.0
		1:
			return 0.90
		2:
			return 0.80
		3:
			return 0.70
		4:
			return 0.60
		5:
			return 0.50
		6:
			return 0.40
		7:
			return 0.30
		8:
			return 0.0
		_:
			return 1.0

func trigger_ram_error():
	ram_error = true
	downloading = true
	errorlabel.show()
	errorlabel.move_to_front()
	resumebtn.hide()


func resume_download():
	if open_ads > 0:
		return

	ram_error = false
	downloading = true

	errorlabel.hide()
	resumebtn.hide()

	ad_spawn_timer = 0.0
	set_next_spawn_time()
