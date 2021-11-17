extends CanvasLayer

var display = ""
var typing_speed = .05
var current_char = 0

var text = ""
var done = true
var talking_to = false

func _ready():
	$NinePatchRect.visible = false

func _input(event):
	if event.is_action_pressed("game_interact") and done and talking_to:
		$NinePatchRect/Message.text = ""
		$NinePatchRect.visible = false
		turn_on_player()
		talking_to = false

func interact(input_text):
	talking_to = true
	done = false
	$NinePatchRect.visible = true
	self.text = input_text
	display = ""
	current_char = 0
	turn_off_player()
	$next_char.set_wait_time(typing_speed)
	$next_char.start()

func _on_next_char_timeout():
	if(current_char < len(text)):
		var next_char = text[current_char]
		display+=next_char
		
		$NinePatchRect/Message.text=display
		current_char += 1
	else:
		$next_char.stop()
		$end_dialogue.start()

func _on_end_dialogue_timeout():
	done = true

func turn_off_player():
	var player = get_tree().get_root().find_node("Player", true, false)
	if player:
		player.set_active(false)

func turn_on_player():
	var player = get_tree().get_root().find_node("Player", true, false)
	if player:
		player.set_active(true)
