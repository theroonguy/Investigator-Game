extends Area2D

export(String, FILE, "*.tscn,*.scn") var target_scene

func _input(event):
	if event.is_action_pressed("game_interact"):
		if !target_scene:
			print("no scene linked to this door")
			return
		if (get_overlapping_bodies().size()) > 0:
			next_level()
			
func next_level():
	var ERR = get_tree().change_scene(target_scene)
