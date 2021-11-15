extends Area2D

func _input(event):
	if event.is_action_pressed("game_interact"):
		for body in get_overlapping_bodies():
			if body.name == "Player":
				find_and_use_dialogue()
		
func find_and_use_dialogue():
	var dialogue_player = get_node_or_null("DialoguePlayer2")
	
	if dialogue_player:
		dialogue_player.play()
