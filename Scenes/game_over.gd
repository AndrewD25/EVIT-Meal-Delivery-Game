extends Control


func _on_retry_pressed():
	var loadingScreen = load("res://loading_screen.tscn")
	get_tree().change_scene_to_packed(loadingScreen)


func _on_main_menu_pressed():
	var mainMenu = load("res://Scenes/main_menu.tscn")
	get_tree().change_scene_to_packed(mainMenu)


func _on_quit_pressed():
	get_tree().quit()
