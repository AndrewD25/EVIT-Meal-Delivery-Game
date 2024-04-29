extends CharacterBody2D

var startPosX
var startPosY

@export var speed = 185

var chasing = false

var random = RandomNumberGenerator.new()
var posrandom = RandomNumberGenerator.new()

func _ready():
	var the_player = get_node("/root/EVIT_Campus/Player")
	the_player.pos_reset.connect(_on_player_pos_reset)
	
	
	%Exclamation.visible = false
	random.randomize()
	var randNum = random.randi_range(1,3)
	var textures = [preload("res://Assets/guard_01.png"), preload("res://Assets/guard_02.png"), preload("res://Assets/guard_03.png")]
	$Sprite2D.texture = textures[randNum - 1]
	
	startPosX = position.x
	startPosY = position.y
	
	#Slightly Change Position
	posrandom.randomize()
	var randX = posrandom.randi_range(-15,15)
	posrandom.randomize()
	var randY = posrandom.randi_range(-15,15)
	position.x += randX
	position.y += randY

func _physics_process(delta):
	var target_player = $Chase_Range.get_overlapping_bodies()
	if target_player.size() == 1:
		if !chasing:
			if !%Alert.playing:
				%Alert.play()
				%Exclamation.visible = true
				%AlertTimer.start()
		chasing = true
		$AnimationPlayer.play("walk_down")
		var player = target_player[0]
		var direction = global_position.direction_to(player.global_position)
		velocity = direction * speed
		if !%Footsteps.playing:
			%Footsteps.play()
		move_and_slide()
	else: 
		chasing = false
		$AnimationPlayer.play("idle")
		if %Footsteps.playing:
			%Footsteps.stop()
	
	var damage_players = $Damage.get_overlapping_bodies()
	if damage_players.size() == 1:
		$AnimationPlayer.play("taser")
		if !%Taser.playing:
			%Taser.play()
		var player = target_player[0]
		player.energy -= 0.6
		player.updateBar()
	else:
		%Taser.stop()


func _on_alert_timer_timeout():
	%Exclamation.visible = false
	
	
func _on_player_pos_reset():
	%Taser.stop()
	%Alert.stop()
	
	%Exclamation.visible = false
	random.randomize()
	var randNum = random.randi_range(1,3)
	var textures = [preload("res://Assets/guard_01.png"), preload("res://Assets/guard_02.png"), preload("res://Assets/guard_03.png")]
	$Sprite2D.texture = textures[randNum - 1]
	
	position.x = startPosX
	position.y = startPosY
	
	#Slightly Change Position
	posrandom.randomize()
	var randX = posrandom.randi_range(-15,15)
	posrandom.randomize()
	var randY = posrandom.randi_range(-15,15)
	position.x += randX
	position.y += randY
