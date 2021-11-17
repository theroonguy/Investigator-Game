extends Area2D

var first_interaction = true
export(NodePath) var descriptorbox
export (Array, String, MULTILINE) var dialogue

var current_interaction = 0

# Interactable Class
func isInteractable():
	return true

func interact():
	if not current_interaction == len(dialogue):
		get_node(descriptorbox).interact(dialogue[current_interaction])
		current_interaction+=1
	else: 
		get_node(descriptorbox).interact(dialogue[current_interaction-1])
