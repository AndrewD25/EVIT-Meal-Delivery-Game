extends CharacterBody2D


@export var speed = 210


func _physics_process(delta):
	var target_player = $Chase_Range.get_overlapping_bodies()
	if target_player.size() == 1:
		$AnimationPlayer.play("walk_down")
		var player = target_player[0]
		var direction = global_position.direction_to(player.global_position)
		velocity = direction * speed
		move_and_slide()
		#if !%ChaseMusic.playing:
			#%ChaseMusic.play()
	else: 
		$AnimationPlayer.play("idle")
		#%ChaseMusic.stop()
	
	var damage_players = $Damage.get_overlapping_bodies()
	if damage_players.size() == 1:
		$AnimationPlayer.play("taser")
		var player = target_player[0]
		player.energy -= 0.5
		player.updateBar()
