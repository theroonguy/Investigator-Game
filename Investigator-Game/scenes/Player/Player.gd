extends KinematicBody2D

const ACCELERATION = 500
export var MAX_SPEED = 40
const FRICTION = 500

var velocity = Vector2.ZERO

func _physics_process(delta):
	
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	input_vector = input_vector.normalized()
	
	if input_vector != Vector2.ZERO:
		velocity = velocity.move_toward(input_vector * MAX_SPEED, ACCELERATION * delta)
	else:
		velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
		
	velocity = move_and_slide(velocity)
	
	if velocity.x > 0:
		$AnimationPlayer.play("WalkRight")
	elif velocity.x < 0:
		$AnimationPlayer.play("WalkLeft")
	else:
		$AnimationPlayer.stop()


func set_active(active):
	set_physics_process(active)
	set_process(active)
	set_process_input(active)
