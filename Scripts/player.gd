extends CharacterBody2D


@export var speed = 300


func _physics_process(delta):
	var direction = Input.get_vector("left", "right", "up", "down")
	velocity = direction * speed
	if velocity.length() > 0:
		$AnimationPlayer.play("walk_down")
	move_and_slide()
