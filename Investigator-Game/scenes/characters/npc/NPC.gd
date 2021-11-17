extends Area2D

export(NodePath) var dialoguebox
export(String, FILE, "*.json") var dialogue_file
var message_num = 0

# Interactable
func isInteractable():
	return true

func interact():
	get_node_or_null(dialoguebox).play(dialogue_file, self.name, message_num)
	message_num += 1
	

func play_second_dialogue():
	print("hello")
