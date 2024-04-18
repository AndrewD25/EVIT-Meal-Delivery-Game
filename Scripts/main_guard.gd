extends CharacterBody2D


@export var speed = 150
@onready var player = get_node("/root/Main/Player")


#vars i'm not using yet but need to 
var follow_player = true


func _physics_process(delta):
	var direction = global_position.direction_to(player.global_position)
	velocity = direction * speed
	move_and_slide()
