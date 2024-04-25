extends Label


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position.y -= 3
	if position.y <= -200:
		queue_free()
