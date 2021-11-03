extends Area2D

export(String, FILE, "*.tscn,*.scn") var target_scene

var in_collision = false

func _input(event):
	if event.is_action_pressed("game_interact"):
		if in_collision:
			if !target_scene:
				print("no scene linked to this door")
				return
			else:
				next_level()
			
func next_level():
	var ERR = get_tree().change_scene(target_scene)

	Global.door_name = name

func _on_Door_body_entered(body):
	if body.get_collision_layer() == 1:
		in_collision = true

func _on_Door_body_exited(body):
	if body.get_collision_layer() == 1:
		in_collision = false
