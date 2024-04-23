extends Area2D

var active : bool = true

@onready var playerNode = get_node("/root/EVIT_Campus/Player")

func _physics_process(_delta):
	var player_overlapping = get_overlapping_bodies()
	if player_overlapping.size() == 1:
		playerNode.interact = true
		if Input.is_action_just_pressed("interact"):
			if active:
				play_end_dialogue()

func play_end_dialogue():
	if playerNode.meals > 0:
		win()

func win():
	active = false
	get_tree().change_scene_to_file("res://Scenes/win_screen.tscn")
