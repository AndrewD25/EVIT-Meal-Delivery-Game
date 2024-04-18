extends Control


func _on_play_pressed():
	var loadingScreen = load("res://loading_screen.tscn")
	get_tree().change_scene_to_packed(loadingScreen)


func _on_exit_pressed():
	get_tree().quit()
