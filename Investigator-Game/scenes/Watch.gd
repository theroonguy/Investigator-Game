extends Control

var pm = ""
var display = ""
var test = 60

func _ready():
	pass

func _process(delta):
	if Global.time_pm: pm = "PM"
	else: pm = "AM"
	if Global.watch_out: $".".visible = true
	else: $".".visible = false
	display = (str(Global.time_hours) + ":" + str(Global.time_minutes) + " " + pm)
	$Display/Time.text = display
	pm = "PM"

func _input(event):
	if event.is_action_pressed("game_watch"):
		if Global.watch_out:
			$".".visible = false
			Global.watch_out = false
		else:
			$".".visible = true
			Global.watch_out = true
