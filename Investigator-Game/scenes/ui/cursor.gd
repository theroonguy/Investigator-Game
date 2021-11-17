extends Area2D

var clicking
var collider
export(NodePath) var player

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	
func _process(delta):
	self.position = self.get_global_mouse_position()
	
	if Global.hovering:
		$Sprite.set_frame(2)
	elif not Global.hovering and not clicking:
		$Sprite.set_frame(0)
	
func _input(event):
	if event.is_action_pressed("click"):
		clicking = true
		$Sprite.set_frame(1)
		
		if Global.hovering:
			if collider.get_global_position().distance_to(get_node(player).get_global_position()) < 20:
				collider.interact()
	elif event.is_action_released("click"):
		clicking = false
		$Sprite.set_frame(0)
		
func _on_Cursor_area_entered(area):
	if area.has_method("isInteractable") and area.isInteractable():
		Global.hovering = true
		collider = area

func _on_Cursor_area_exited(area):
	if area.has_method("isInteractable") and area.isInteractable():
		Global.hovering = false
		collider = ""
