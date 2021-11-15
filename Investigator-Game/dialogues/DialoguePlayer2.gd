extends CanvasLayer

export(String, FILE, "*.json") var dialogue_file
var NPCName = ""

var dialogues = []
var current_dialogue_id = 0
var is_dialogue_active = false

var item_id = 0

var display = ""
var typing_speed = .05
var current_char = 0

func _ready():
	$NinePatchRect.visible = false
	
#func _process(delta):
#	print(item_id)

func play():
	self.NPCName = get_parent().name
	if is_dialogue_active:
		return
		
	dialogues=load_dialogue()
	
	for item in dialogues:
		if item["name"] == self.NPCName:
				
			item_id = item["id"]
				
			turn_off_player()
			is_dialogue_active = true
			$NinePatchRect.visible = true
			current_dialogue_id = 0
			
			display = ""
			current_char = 0
			$next_char.set_wait_time(typing_speed)
			$next_char.start()
	
func _input(event):
	if not is_dialogue_active:
		return
	
	if event.is_action_pressed("game_interact"):
		next_line()
		
func next_line():
	current_dialogue_id += 1
	if current_dialogue_id >= len(dialogues[item_id]["dialogue"]):
		display=""
		$NinePatchRect/Message.text = display
		$NinePatchRect/Name.text = ""
		$end_dialogue.start()
		$NinePatchRect.visible = false
		turn_on_player()
		$next_char.stop()
		return
	else:
		display = ""
		current_char = 0
		$next_char.set_wait_time(typing_speed)
		$next_char.start()
	
func load_dialogue():
	var file = File.new()
	if file.file_exists(dialogue_file):
		file.open(dialogue_file, file.READ)
		return parse_json(file.get_as_text())

func _on_end_dialogue_timeout():
	is_dialogue_active = false

func _on_next_char_timeout():
	if (current_char < len(dialogues[item_id]["dialogue"][current_dialogue_id]["text"])):
		var next_char = dialogues[item_id]["dialogue"][current_dialogue_id]["text"][current_char]
		display += next_char
		
		$NinePatchRect/Name.text = dialogues[item_id]["dialogue"][current_dialogue_id]["name"]
		$NinePatchRect/Message.text = display
		current_char += 1
	else:
		$next_char.stop()

func turn_off_player():
	var player = get_tree().get_root().find_node("Player", true, false)
	if player:
		player.set_active(false)

func turn_on_player():
	var player = get_tree().get_root().find_node("Player", true, false)
	if player:
		player.set_active(true)
