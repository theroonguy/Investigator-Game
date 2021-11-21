extends Node

const TRANS = Tween.TRANS_SINE
const EASE = Tween.EASE_IN_OUT

export var amplitude = 16.0
export var frequency = 15.0

onready var camera = get_parent()

func _ready():
	start(frequency, amplitude)

func start(frequency = 12, amplitude = 0.2):
	self.amplitude = amplitude
	
	$Frequency.wait_time = 1 / float(frequency)
	$Frequency.start()
	
	_new_shake()

func _new_shake():
	var rand = Vector2()
	rand.x = rand_range(-amplitude, amplitude)
	rand.y = rand_range(-amplitude, amplitude)
	
	$ShakeTween.interpolate_property(camera, "offset", camera.offset, rand, $Frequency.wait_time, TRANS, EASE)
	
	$ShakeTween.start()

func _on_Frequency_timeout():
	_new_shake()
