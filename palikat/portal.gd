extends Area2D

# seuraavan kentän paikka kansiossa. e.g "res://scenet/levelit/level1.tscn"
export(String) var next_level_path

func _on_portal_body_entered(body):
	if body is Player: # Jos pelaaja osu portaaliin 
		# Käynnistä partikkelit ja piilota pelaaja.
		$finished_particles.emitting = true
		body.visible = false
		
		# Odota 1 sekuntti ja vaihda kenttää, "finished_particles" kestää yhen sekunnin.
		yield(get_tree().create_timer(1.0), "timeout")
		get_tree().change_scene(next_level_path)
