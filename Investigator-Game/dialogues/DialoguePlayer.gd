extends CanvasLayer

var dialogues = []
var current_dialogue_id = -2
var is_dialogue_active = false

var dialogue_file

var item_id = 0
var message_num = -1

var display = ""
var typing_speed = .05
var current_char = 0
var current_segment = 0

var type

var can_interact = true
var typing = false

func _ready():
	$NinePatchRect.visible = false

func can_interact():
	return can_interact

func play(dialogue, name, type, interaction_num):
	self.type = type
	self.dialogue_file = dialogue
	self.message_num = interaction_num
	if is_dialogue_active:
		return
	
	dialogues=load_dialogue()
	
	for item in dialogues:
		if item["name"] == name:	# find matching name in json file
			item_id = item["id"]
			turn_off_player()
			is_dialogue_active = true
			$NinePatchRect.visible = true
			current_dialogue_id = -1
			
			display = ""
			current_char = 0
			current_segment = 0
			next_line()

func compile_text():
	var compiled_text = ""
	for segment in dialogues[item_id]["dialogue"][message_num]["interaction"][current_dialogue_id]["message"]:
		compiled_text += segment["segment"]
	return compiled_text

func _input(event):
	if not is_dialogue_active:
		return
	
	if event.is_action_pressed("game_interact") and not typing:
		next_line()
	elif event.is_action_pressed("game_interact") and typing:
		skip_writing()
		
func next_line():
	current_dialogue_id += 1		# move to next line in message
	
	# if text is done reading, quit dialogue player
	if current_dialogue_id >= len(dialogues[item_id]["dialogue"][message_num]["interaction"]):
		close_dialogue()
		return
	else:		# clear dialogue box and continue to next line from scratch
		display = ""
		current_char = 0
		current_segment = 0
		$next_char.set_wait_time(typing_speed)
		$next_char.start()

func skip_writing():
	$next_char.stop()
	display = ""
	if type == "description":
		$NinePatchRect/Description.text = compile_text()
	elif type == "dialogue":
		$NinePatchRect/Message.text = compile_text()
	typing = false

func close_dialogue():
	display=""
	$NinePatchRect/Message.text = ""
	$NinePatchRect/Name.text = ""
	$NinePatchRect/Description.text = ""
	$end_dialogue.start()
	$NinePatchRect.visible = false
	turn_on_player()
	$next_char.stop()
	can_interact = true

func load_dialogue():
	var file = File.new()
	if file.file_exists(self.dialogue_file):
		file.open(self.dialogue_file, file.READ)
		return parse_json(file.get_as_text())

func turn_off_player():
	var player = get_tree().get_root().find_node("Player", true, false)
	if player:
		player.set_active(false)

func turn_on_player():
	var player = get_tree().get_root().find_node("Player", true, false)
	if player:
		player.set_active(true)

func _on_end_dialogue_timeout():
	is_dialogue_active = false

func _on_next_char_timeout():
	if (current_segment < len(dialogues[item_id]["dialogue"][message_num]["interaction"][current_dialogue_id]["message"])):
		if (current_segment < len(dialogues[item_id]["dialogue"][message_num]["interaction"][current_dialogue_id]["message"])):
			$next_char.set_wait_time(dialogues[item_id]["dialogue"][message_num]["interaction"][current_dialogue_id]["message"][current_segment]["speed"])
		if (current_char < len(dialogues[item_id]["dialogue"][message_num]["interaction"][current_dialogue_id]["message"][current_segment]["segment"])):
			var next_char = dialogues[item_id]["dialogue"][message_num]["interaction"][current_dialogue_id]["message"][current_segment]["segment"][current_char]
			display += next_char		# add new character
			
			# change formatting depending on if the type is dialogue or description
			if self.type == "dialogue":
				$NinePatchRect/Name.text = dialogues[item_id]["dialogue"][message_num]["interaction"][current_dialogue_id]["name"]
				$NinePatchRect/Message.text = display
			elif self.type == "description":
				$NinePatchRect/Description.text = display
			current_char += 1
			can_interact = false
			typing = true
		else:
			current_char = 0
			current_segment += 1
	else:
		$next_char.stop()
		typing = false
