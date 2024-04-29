extends Control

signal restart

func _ready():
	%Animator.play("rest")


func _on_retry_pressed():
	restart.emit()


func _on_main_menu_pressed():
	var mainMenu = load("res://Scenes/main_menu.tscn")
	get_tree().change_scene_to_packed(mainMenu)


func _on_quit_pressed():
	get_tree().quit()
