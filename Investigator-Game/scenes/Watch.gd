extends Control

var pm = ""
var display = ""

func _ready():
	count()
	
func count():
	$Timer.start()

func _on_Timer_timeout():
	Global.time_seconds += 5
	$AnimationPlayer.play("pull_down")
	if Global.time_seconds == 60:
		Global.time_seconds = 0
		Global.time_minutes += 1
	if Global.time_minutes == 60:
		Global.time_minutes = 0
		Global.time_hours += 1
	if Global.time_hours == 12:
		Global.time_pm = true
		Global.time_hours = 0
		pm = "PM"
	
	display = (str(Global.time_hours) + ":" + str(Global.time_minutes) + " " + pm)
	
	$Display/Time.text = display
	count()
