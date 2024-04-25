extends Control



func _on_play_2_pressed():
	var loadingScreen = load("res://Scenes/loading_screen.tscn")
	get_tree().change_scene_to_packed(loadingScreen)
