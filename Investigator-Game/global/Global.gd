extends Node

# doors
var door_name = null

# time
var time = 0
var time_seconds = 0
var time_minutes = 0
var time_hours = 0
var time_pm = false
var time_mult = 20.0
var paused = false

var watch_out = false

func _ready():
  set_process(true)

func _process(delta):
	# time/watch
	if not paused: time += delta * time_mult
	if(int(round(Global.time))%1==0): time_seconds += 1
	if time_seconds >= 60:
		time_seconds = 0
		time_minutes += 1
	if time_minutes >= 60:
		time_hours += 1
		time_minutes = 0
	if time_hours >= 12: time_pm = true
