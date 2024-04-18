extends CharacterBody2D


@export var speed = 300

var energyBar
var energy

#vars i'm not using yet but need to 
var losingEnergy = true


func _ready():
	energyBar = get_node("EnergyBar")
	energy = energyBar.value
	
	#Set location
	%CurrentLocation.text = get_parent().name


func _physics_process(delta):
	var direction = Input.get_vector("left", "right", "up", "down")
	
	var sprintMulti = 0
	if Input.is_action_pressed("sprint"):
		sprintMulti = 1
	
	velocity = direction * speed * (1 + 0.5 * sprintMulti)
	if velocity.length() > 0:
		$AnimationPlayer.play("walk_down")
		if energyBar.value > 0:
			energy -= 0.05 * (1 + 1 * sprintMulti)
		energyBar.value = energy
	else:
		$AnimationPlayer.play("idle_down")
	move_and_slide()

