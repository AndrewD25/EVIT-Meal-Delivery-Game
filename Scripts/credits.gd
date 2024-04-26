extends Control

var Credits = preload("res://Scenes/credit_name.tscn")

var lastThree = []

func _on_back_pressed():
	get_tree().change_scene_to_file("res://Scenes/main_menu.tscn")


func _on_timer_timeout():
	var credit = Credits.instantiate()
	credit.position.y = 678
	credit.position.x = 421
	add_child(credit)
