extends Node2D

func _ready():
	print(Global.door_name)

	# code for finding the door:
	if Global.door_name:
		var door_node = find_node(Global.door_name)
		if door_node:
			$YSort/Player.global_position = door_node.global_position
