extends Area2D

#location variables
@export var x_pos:int
@export var y_pos:int


func _physics_process(_delta):
	var player_overlapping = get_overlapping_bodies()
	var playerNode = get_node("/root/EVIT_Campus/Player")
	if player_overlapping.size() == 1:
		var player = player_overlapping.front()
		playerNode.interact = true
		if Input.is_action_just_pressed("interact"):
			playerNode.position.x = x_pos
			playerNode.position.y = y_pos
