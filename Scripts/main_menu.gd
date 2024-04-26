extends Control


func _ready():
	%Animator.play("run")
	

func _on_play_pressed():
	get_tree().change_scene_to_file("res://Scenes/instruction_screen.tscn")



func _on_exit_pressed():
	get_tree().quit()
	


func _on_credit_pressed():
	get_tree().change_scene_to_file("res://Scenes/credit_screen.tscn")
