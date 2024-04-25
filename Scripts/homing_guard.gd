extends CharacterBody2D


@export var speed = 210

var random = RandomNumberGenerator.new()

func _ready():
	random.randomize()
	var randNum = random.randi_range(1,3)
	var textures = [preload("res://Assets/guard_01.png"), preload("res://Assets/guard_02.png"), preload("res://Assets/guard_03.png")]
	$Sprite2D.texture = textures[randNum - 1]

func _physics_process(delta):
	var target_player = $Chase_Range.get_overlapping_bodies()
	if target_player.size() == 1:
		$AnimationPlayer.play("walk_down")
		var player = target_player[0]
		var direction = global_position.direction_to(player.global_position)
		velocity = direction * speed
		if !%Footsteps.playing:
			%Footsteps.play()
		move_and_slide()
		#if !%ChaseMusic.playing:
			#%ChaseMusic.play()
	else: 
		$AnimationPlayer.play("idle")
		if %Footsteps.playing:
			%Footsteps.stop()
		#%ChaseMusic.stop()
	
	var damage_players = $Damage.get_overlapping_bodies()
	if damage_players.size() == 1:
		$AnimationPlayer.play("taser")
		var player = target_player[0]
		player.energy -= 0.65
		player.updateBar()
