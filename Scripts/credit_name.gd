extends Label

var random = RandomNumberGenerator.new()

var options = ["Created By", "Designed By", "Programmed By", "Menus By", "Campus Map Designed By",
"Chief Researcher", "Lead Designer", "President", "Special Thanks To", "Acknowledgements", "Credits By",
"Producer", "A Game By", "Editor", "Music Lead", "Art Director", "Chief Tester", "Cast", "Dog Handler",
"Head Chef", "Cooked Up By", "Inspired By Mr. Saar and", "Chief of Operations", "Is Getting an A for this Project",
"I Ain't Reading all That", "ASJKDHAJKDHAKJ"]

func _ready():
	random.randomize()
	var randNum = random.randi_range(1,len(options))
	
	var texttoutput = options[randNum - 1]
	
	var credScreen = get_node("/root/CreditScreen")
	
	if len(credScreen.lastThree) > 0:
		while credScreen.lastThree.has(texttoutput):
			random.randomize()
			randNum = random.randi_range(1,len(options))
			texttoutput = options[randNum - 1]
	elif len(credScreen.lastThree) == 0:
		texttoutput = options[0]
	
	credScreen.lastThree.append(texttoutput)

	if len(credScreen.lastThree) > 3:
		credScreen.lastThree.pop_front()
	
	$Label.text = texttoutput

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position.y -= 2
	if position.y <= -200:
		queue_free()
