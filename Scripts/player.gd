extends CharacterBody2D


@export var speed = 300

var energyBar
var energy
@export var meals = 5
@export var interact = false
var losingEnergy = true
@export var canMove = true


var gameOverTimer = 0

@onready var b3 = get_parent().get_node("building_3")


func _ready():
	energyBar = %EnergyBar
	energy = energyBar.value
	meals = 5
	position.x = -252
	position.y = 327
	%Arrow.visible = true
	
	#Set location
	%CurrentLocation.text = "EVIT Campus" #Re-add new detection system 


func _physics_process(delta):
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
	if energy > 0.005 and meals > 0 and canMove:
		velocity = direction * speed * (1 + 0.5 * sprintMulti)
		if velocity.length() > 0:
			$AnimationPlayer.play("walk_down")
			if energyBar.value > 0:
				if losingEnergy:
					energy -= 0.055 * (1 + 1 * sprintMulti)
			updateBar()
			if !%Footsteps.playing:
				%Footsteps.play()
		else:
			$AnimationPlayer.play("idle_down")
			if %Footsteps.playing:
				%Footsteps.stop()
			
		move_and_slide()
	elif canMove: 
		$AnimationPlayer.play("tired")
		gameOverTimer += 1
		if gameOverTimer >= 200:
			get_tree().change_scene_to_file("res://Scenes/game_over.tscn")

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

