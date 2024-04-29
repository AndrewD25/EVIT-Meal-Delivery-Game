extends Area2D

@onready var the_player = get_node("/root/EVIT_Campus/Player")
var active = true

func _ready():
	the_player.pos_reset.connect(_on_player_pos_reset)


func _physics_process(delta):
	var target_player = get_overlapping_bodies()
	if target_player.size() == 1 and active:
		the_player.energy += 30
		if the_player.energy > 100:
			the_player.energy = 100
			the_player.updateBar()
		active = false
		visible = false


func _on_player_pos_reset():
	active = true
	visible = true
