extends KinematicBody2D
class_name Player

const GRAVITY       = 45
const JUMP_STRENGTH = 720
const MOVE_SPEED    = 420
const CROUCH_SPEED  = 220
const MAX_JUMPS     = 2 # 1 in ground and 1 in air

var motion := Vector2()
var is_crouching = false
var jumps_left = 2 # hyppääminen miinustaa ja maahan koskeminen laitaa takas kahdeksi, tupla hyppy.

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
