extends Area2D

var hovering = false
var in_range = false

func _input(event):
#	if event is InputEventMouseButton and event.pressed and event.button_index == BUTTON_LEFT:
	
	if event.is_action_pressed("click"):
		for body in get_overlapping_areas():
			if hovering == true and in_range == true:
				find_and_use_dialogue()
#	if event.is_action_pressed("game_interact"):


func find_and_use_dialogue():
	var dialogue_player = get_node_or_null("DialoguePlayer2")
	
	if dialogue_player:
		dialogue_player.play()

func _on_CursorCollision_area_entered(area):
	if area.name == "Cursor":
		hovering = true
	if in_range:
		Global.hovering = true

func _on_CursorCollision_area_exited(area):
	if area.name == "Cursor":
		Global.hovering = false
		hovering = false

func _on_PlayerCollision_body_entered(body):
	if body.name == "Player":
		in_range = true
	if hovering:
		Global.hovering = true

func _on_PlayerCollision_body_exited(body):
	if body.name == "Player":
		in_range = false
		Global.hovering = false
		hovering = false
