extends Control


# Kun peliin nappulaa painetaan.
func _on_peliin_pressed():
	get_tree().change_scene("res://scenet/levelit/level1.tscn")
