extends CharacterBody2D

signal pos_reset

@export var speed = 300
var oldVelocity:Vector2
var energyBar
var energy
@export var meals = 5
@export var interact = false
var losingEnergy = true
@export var canMove = true
var paused = false
var gameOverTimer = 0

@onready var b3 = get_parent().get_node("building_3")
@onready var main_game_audio = get_parent().get_node("BGM")

func _ready():
	$AnimationPlayer.play("idle_down")
	energyBar = %EnergyBar
	energy = 100
	updateBar()
	meals = 5
	position.x = -252
	position.y = 327
	%Arrow.visible = true
	%PauseMenu.visible = false
	%GameOverMenu.visible = false
	
	#Set location
	%CurrentLocation.text = "EVIT Campus" #Re-add new detection system 


func _physics_process(delta):
	if Input.is_action_just_pressed("pause"):
		%PauseMenu.visible = !%PauseMenu.visible
		paused = !paused
		get_tree().paused = !get_tree().paused
	
	var direction = Input.get_vector("left", "right", "up", "down")
	
	
	var sprintMulti = 0
	if Input.is_action_pressed("sprint"):
		sprintMulti = 1
		
	#Show interact
	if interact:
		%Keyprompt.visible = true
	else:
		%Keyprompt.visible = false
	interact=false
	
	#Point arrow at superintendent$"../Building 3"
	%Arrow.look_at(b3.position)
	
	#Display meals remaining
	%MealsRemaining.text = str(meals)
	
	#Move if energy left
	if energy > 0.005 and meals > 0 and canMove and !paused:
		velocity = direction * speed * (1 + 0.5 * sprintMulti)
		
		if velocity.length() > 0:
			#Animation
			if velocity.y > 0:
				$AnimationPlayer.play("walk_down")
			elif velocity.y < 0:
				$AnimationPlayer.play("walk_up")
			elif velocity.x < 0:
				$AnimationPlayer.play("walk_left")
			elif velocity.x > 0:
				$AnimationPlayer.play("walk_right")
				
			oldVelocity = velocity
			
			if energyBar.value > 0:
				if losingEnergy:
					energy -= 0.055 * (1 + 1 * sprintMulti)
			updateBar()
			if !%Footsteps.playing:
				%Footsteps.play()
			else:
				%Footsteps.pitch_scale = 1 + 1 * sprintMulti
		else:
			if oldVelocity.y > 0:
				$AnimationPlayer.play("idle_down")
			elif oldVelocity.y < 0:
				$AnimationPlayer.play("idle_up")
			elif oldVelocity.x < 0:
				$AnimationPlayer.play("idle_left")
			elif oldVelocity.x > 0:
				$AnimationPlayer.play("idle_right")
			
			if %Footsteps.playing:
				%Footsteps.stop()
			
		move_and_slide()
	elif canMove and !paused: 
		$AnimationPlayer.play("tired")
		gameOverTimer += 1
		if gameOverTimer >= 200:
			game_over()

func updateBar():
	energyBar.value = energy
	
func insideFlip():
	losingEnergy = !losingEnergy
	%Arrow.visible = !%Arrow.visible

func refill(): 
	if meals > 0:
		meals -= 1
		energy = 100
		%MealDialogue.visible = true
		%DiaTimer.start()
		updateBar()

func _on_dia_timer_timeout():
	%MealDialogue.visible = false


func _on_resume_pressed():
	%PauseMenu.visible = false
	paused = false
	get_tree().paused = false


func _on_controls_pressed():
	%PauseMenu.visible = false
	get_tree().paused = false
	get_tree().change_scene_to_file("res://Scenes/instruction_screen.tscn")


func _on_mainu_pressed():
	%PauseMenu.visible = false
	get_tree().paused = false
	get_tree().change_scene_to_file("res://Scenes/main_menu.tscn")
	
func game_over():
	pos_reset.emit()
	
	%PauseMenu.visible = false
	%GameOverMenu.visible = true
	%Footsteps.stop()
	main_game_audio.stop()
	%GameOver.get_node("MusicPlayer").playing = true
	canMove = false


func _on_game_over_restart():
	
	%GameOverMenu/GameOver/MusicPlayer.stop()
	main_game_audio.play()
	$AnimationPlayer.play("idle_down")
	energyBar = %EnergyBar
	energy = 100
	updateBar()
	meals = 5
	position.x = -252
	position.y = 327
	%Arrow.visible = true
	%PauseMenu.visible = false
	%GameOverMenu.visible = false
	canMove = true
	
	if !losingEnergy:
		insideFlip()
	
	#Set location
	%CurrentLocation.text = "EVIT Campus" #Re-add new detection system
