extends Control

# Ajastin
var ms := 0
var s  := 0
var m  := 0

func _ready():
	visible = false

func start_timer():
	visible = true
	
	# Resettaa ajastin
	ms = 0
	s  = 0
	m  = 0

func stop_timer():
	visible = false

func get_time():
	return "%s:%s.%s" % [m, str(s).pad_zeros(2), str(ms).pad_zeros(2)]

func update_timer(delta:float):
	# Älä päivitä ajastinta jos ei ole näkyvillä.
	if !visible:
		return
	
	# Lisää millisekunnit
	ms += (delta * 100.0)
	
	# Jos yli 1000ms niin lisää 1 sekuntteihin, ja miinusta 1000 millisekunneista.
	if ms >= 100:
		ms -= 100
		s += 1
	# Jos sekunnit yli 60 niin lisää 1 minuutteihin ja miinusta 60 sekunttia.
	if s >= 60:
		s -= 60
		m += 1
	
	# Päivitä ajastimen teksti.
	$timer.text = "Timer: " + get_time()

func update_deathcount():
	$death_count.text = "Deaths: %s" % [Globals.death_count]

func _physics_process(delta:float):
	update_timer(delta)
	update_deathcount()
