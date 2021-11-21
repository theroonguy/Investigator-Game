extends KinematicBody2D

const ACCELERATION = 250
export var MAX_SPEED = 40
const FRICTION = 500

var facing = "down"

var velocity = Vector2.ZERO

onready var player = get_node(".")

func _ready():
	$AnimationPlayer.playback_speed = MAX_SPEED/10.4

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
		$AnimatedSprite.play("walk_left")
		$AnimatedSprite.flip_h = true
	elif velocity.x < 0:
		$AnimatedSprite.play("walk_left")
		$AnimatedSprite.flip_h = false
	else:
		$AnimatedSprite.stop()
#
#	if velocity.x > 0:
#		$AnimationPlayer.play("WalkRight")
#		facing = "right"
#	elif velocity.x < 0:
#		$AnimationPlayer.play("WalkLeft")
#		facing = "left"
#	elif velocity.y > 0:
#		$AnimationPlayer.play("WalkUp")
#		facing = "down"
#	elif velocity.y < 0:
#		$AnimationPlayer.play("WalkDown")
#		facing = "up"
#	else:
#		$AnimationPlayer.stop()
#		if facing == "down": $Sprite2.set_frame(0)
#		elif facing == "right": $Sprite2.set_frame(4)
#		elif facing == "left": $Sprite2.set_frame(12)

func set_active(active):
	set_physics_process(active)
	set_process(active)
	set_process_input(active)
