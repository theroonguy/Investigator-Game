extends Area2D

var first_interaction = true
export(NodePath) var descriptorbox
export(String, FILE, "*.json") var dialogue_file

var current_interaction = 0

# Interactable Class
func isInteractable():
	return true

func interact():
	get_node(descriptorbox).play(dialogue_file, self.name)
