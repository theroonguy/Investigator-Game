extends Area2D

export(NodePath) var dialoguebox
export(String, FILE, "*.json") var dialogue_file
export(NodePath) var camera

var current_interaction = -1
var dialogues

func load_dialogue():
	var file = File.new()
	if file.file_exists(self.dialogue_file):
		file.open(self.dialogue_file, file.READ)
		return parse_json(file.get_as_text())

# Interactable
func isInteractable():
	return true

func interact():
	if get_node(dialoguebox).can_interact():
		dialogues = load_dialogue()
		for item in dialogues:
			if item["name"] == name:	# find matching name in json file
				var item_id = item["id"]
				if current_interaction+1 < len(dialogues[item_id]["dialogue"]): 
					current_interaction += 1
				get_node_or_null(dialoguebox).play(dialogue_file, self.name, "dialogue", current_interaction)
