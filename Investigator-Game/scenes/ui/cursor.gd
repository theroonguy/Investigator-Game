extends Node2D

var clicking

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	
func _process(delta):
	self.position = self.get_global_mouse_position()
	
	if Global.hovering:
		$Sprite.set_frame(2)
	elif not Global.hovering and not clicking: $Sprite.set_frame(0)
	
	
func _input(event):
	if event.is_action_pressed("click"):
		clicking = true
		$Sprite.set_frame(1)
	elif event.is_action_released("click"):
		clicking = false
		$Sprite.set_frame(0)
		
