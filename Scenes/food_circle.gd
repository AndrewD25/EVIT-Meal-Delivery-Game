extends Area2D

var active : bool = true

func _physics_process(_delta):
	var player_overlapping = get_overlapping_bodies()
	var playerNode = get_node("/root/EVIT_Campus/Player")
	if player_overlapping.size() == 1:
		playerNode.interact = true
		if Input.is_action_just_pressed("interact"):
			if active:
				deliver_meal(playerNode)

func deliver_meal(player):
	player.refill()
	$ColorRect.color = Color("ea00327a")
	active = false
	
	
