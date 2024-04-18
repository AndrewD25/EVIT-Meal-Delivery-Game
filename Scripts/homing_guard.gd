extends CharacterBody2D


@export var speed = 210


func _physics_process(delta):
	var target_player = $Chase_Range.get_overlapping_bodies()
	if target_player.size() == 1:
		var player = target_player[0]
		var direction = global_position.direction_to(player.global_position)
		velocity = direction * speed
		move_and_slide()
	
