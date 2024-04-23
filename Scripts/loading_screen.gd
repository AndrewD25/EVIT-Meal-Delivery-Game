extends Control

var progress = [0]
var sceneName
var scene_load_status

var previous : int

func _ready():
	sceneName = "res://Scenes/main.tscn"
	ResourceLoader.load_threaded_request(sceneName)
	%ChefAnimator.play("spin");
	
func _process(delta):
	scene_load_status = ResourceLoader.load_threaded_get_status(sceneName,progress)
	var progressCent = int(floor(progress[0]*100))
	if progressCent > previous:
		$countDown.text = str(progressCent) + "%"
		previous = progressCent
	if scene_load_status == ResourceLoader.THREAD_LOAD_LOADED:
		var newScene = ResourceLoader.load_threaded_get(sceneName)
		get_tree().change_scene_to_packed(newScene)
