extends Area2D

func _on_portal_body_entered(body):
	if body is Player: # Jos pelaaja osu, alota kenttä uusiks
		body.die()
