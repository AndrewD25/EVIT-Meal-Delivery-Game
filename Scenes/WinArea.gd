extends Area2D

var active : bool = true
var dialogue = 0

var dialogueOptions = [
	"Thank you kind student. I hope my guards weren't too much of a bother to you. Now, let's see if you brought me the right order...",
	"A bit close to utter failure for my liking, but thank you for this single meal. I'm going to be hungry...",
	"I'm a tad bit disappointed but thank you for bringing me these two meals. Perfect for sharing with a special someone",
	"Three is the magic number. I applaud you for making it with over half of my order intact.",
	"Seems like you lost a meal along the way, but you still brought me plenty to share with my wonderful staff. Thank you",
	"A perfect order?! I will be giving you a wonderful tip",
	"Thank you again for the meal delivery. I hope you enjoy your time at EVIT. And don't forget your ID next time so you can avoid trouble!"
]

@onready var playerNode = get_node("/root/EVIT_Campus/Player")

#Testing
func _physics_process(_delta):
	var player_overlapping = get_overlapping_bodies()
	if player_overlapping.size() == 1:
		playerNode.interact = true
		
		if Input.is_action_just_pressed("interact"):
			
			playerNode.canMove = false
			
			if active and playerNode.meals > 0:
				dialogue = 1
				active = false
			elif dialogue == 1:
				dialogue = 1 + playerNode.meals
			elif dialogue >= 2 and dialogue <= 6:
				dialogue = 7
			elif dialogue == 7:
				win()


	if dialogue > 0 and dialogue < 8:
		%DialogueBox.visible = true
		%DiaText.text = dialogueOptions[dialogue - 1]

func win():
	get_tree().change_scene_to_file("res://Scenes/win_screen.tscn")

#
#func _physics_process(_delta):
	#var player_overlapping = get_overlapping_bodies()
	#if player_overlapping.size() == 1:
		#playerNode.interact = true
		#if Input.is_action_just_pressed("interact"):
			#print(dialogue)
			#if active and playerNode.meals > 0:
				#play_end_dialogue()
			#elif dialogue == 1:
				#dialogue = 1 + playerNode.meals
			#elif dialogue >= 2 or dialogue <= 6:
				#dialogue = 7
			#elif dialogue == 7:
				#get_tree().change_scene_to_file("res://Scenes/win_screen.tscn")
				#
			#if dialogue > 0 and dialogue < 7:
				#%DialogueBox.visible = true
				#%DiaText.text = dialogueOptions[dialogue - 1]
#
#func play_end_dialogue():
	#print("We ran win")
	#playerNode.canMove = false
	#active = false
	#dialogue = 1
