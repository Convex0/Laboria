extends CharacterBody2D

const SPEED = 120.0
var last_direction = "Right"

@onready var sprite = $AnimatedSprite2D

func _physics_process(_delta):
	velocity = _get_input_direction()
	move_and_slide()
	
	sprite.flip_h = (last_direction == "Left")
	
	if velocity == Vector2.ZERO:
		sprite.stop()
		sprite.frame = 0
	else:
		sprite.play("Moving")
		
func _get_input_direction():
	var x = -int(Input.is_action_pressed("Move LT")) + int(Input.is_action_pressed("Move RT"))
	var y = -int(Input.is_action_pressed("Move UP")) + int(Input.is_action_pressed("Move DW"))
	var dir = Vector2(x, y)
	
	if x != 0:
		last_direction = "Right" if x > 0 else "Left"
	
	return dir.normalized() * SPEED
