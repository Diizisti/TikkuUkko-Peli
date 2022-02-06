extends KinematicBody2D
class_name Player

const BLOOD_PARTICLE = preload("res://pelaaja/veri.tscn")
const GRAVITY       = 45
const JUMP_STRENGTH = 720
const MOVE_SPEED    = 420
const CROUCH_SPEED  = 220
const MAX_JUMPS     = 2 # 1 in ground and 1 in air

onready var spawn_pos = global_position # Tallenna alotus positio respawnausta varten kun kuolee.
var motion  = Vector2()
var is_crouching = false
var jumps_left = MAX_JUMPS # hyppääminen miinustaa ja maahan koskeminen laitaa takas kahdeksi, tupla hyppy.

func _ready():
	modulate = Globals.player_color

func _play_animation(anim:String):
	if $sprite.animation != anim: # Älä vaihda samaan animaation, jos se onjo pyörimäs.
		$sprite.animation = anim

func _physics_process(delta):
	# Vetovoima
	motion.y += GRAVITY
	
	# Kyykkimine
	if Input.is_action_pressed("crouch") and is_on_floor():
		is_crouching = true
	else:
		is_crouching = false
	
	# Sivuille liikkumine
	motion.x = 0
	if Input.is_action_pressed("right"):
		if is_crouching:
			motion.x = CROUCH_SPEED
		else:
			motion.x = MOVE_SPEED
		$sprite.flip_h = false
	if Input.is_action_pressed("left"):
		if is_crouching:
			motion.x = -CROUCH_SPEED
		else:
			motion.x = -MOVE_SPEED
		$sprite.flip_h = true
	
	# Animaatiot
	if motion.y < -GRAVITY:
		_play_animation("jumping")
	elif motion.y > GRAVITY:
		_play_animation("falling")
	elif is_crouching == true:
		if abs(motion.x) > 1.0:
			_play_animation("crouch_walk")
		else:
			_play_animation("crouch")
	elif abs(motion.x) > 1.0:
		_play_animation("running")
	else:
		_play_animation("idle")
	
	# Jos on maassa niin resettaa hyppylaskurin
	if is_on_floor():
		jumps_left = MAX_JUMPS
	# Hyppimine
	if Input.is_action_just_pressed("jump") and jumps_left > 0:
		jumps_left -= 1
		motion.y = -JUMP_STRENGTH
	# Liiku
	motion = move_and_slide(motion, Vector2.UP)
	
	# Takaisin alkuruutuun "ESC":istä
	if Input.is_action_just_pressed("ui_cancel"):
		Gui.stop_timer()
		get_tree().change_scene("res://scenet/alotusruutu.tscn")

# kill the player
func die():
	# Jos pelaaja ei oo näkyvillä niin unoha :D, portaali pistää pelaajan näkymättömäks.
	if !visible:
		return
	Globals.death_count += 1
	
	# Veri partikkelit
	var instance = BLOOD_PARTICLE.instance()
	add_child(instance)
	instance.set_as_toplevel(true)
	instance.global_position = global_position
	instance.emitting = true
	
	# Alota alusta
	set_deferred("global_position", spawn_pos) # global_position = spawn_pos
