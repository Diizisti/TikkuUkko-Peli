extends Control

onready var stats = $stats

func _ready():
	# Näytä statsit siitä että kuin hyvin pelasit.
	Gui.stop_timer()
	stats.text = "Aikasi: %s\n"  % Gui.get_time()
	stats.text+= "Kuolemasi: %s" % Globals.death_count

func _physics_process(delta):
	# Sammuta peli "ESC":stä
	if Input.is_action_just_pressed("ui_cancel"):
		get_tree().quit()

# Takaisin Alotusruutuun.
func _alkuun():
	get_tree().change_scene("res://scenet/alotusruutu.tscn")
