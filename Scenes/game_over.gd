extends Control


func _on_retry_pressed():
	get_tree().change_scene_to_file("res://Scenes/loading_screen.tscn")


func _on_main_menu_pressed():
	var mainMenu = load("res://Scenes/main_menu.tscn")
	get_tree().change_scene_to_packed(mainMenu)


func _on_quit_pressed():
	get_tree().quit()
