extends Area2D

# seuraavan kentän paikka kansiossa. e.g "res://scenet/levelit/level1.tscn"
export(String) var next_level_path

func _on_portal_body_entered(body):
	if body is Player: # Jos pelaaja osu portaaliin niin vaihda kenttää
		get_tree().change_scene(next_level_path)
