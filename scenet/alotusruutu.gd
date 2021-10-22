extends Control

func _ready():
	_update_player_color()

# Kun peliin nappulaa painetaan.
func _on_peliin_pressed():
	get_tree().change_scene("res://scenet/levelit/level1.tscn")
	Gui.start_timer()

# Kun väriä vaihdetaan mistään 3:mesta eri sliderista
func _update_player_color(_value := 0.0): # "_value" on turha, joka tulee ton signaalin mukana.
	Globals.player_color = Color($sliders/r.value, $sliders/g.value, $sliders/b.value)
	$sprite.modulate = Globals.player_color

func _physics_process(delta):
	# Sammuta peli "ESC":istä
	if Input.is_action_just_pressed("ui_cancel"):
		get_tree().quit()
