extends Node2D

@onready var _animated_sprite = $AnimatedSprite2D
# Called when the node enters the scene tree for the first time.
func _ready():
	var current_frame = _animated_sprite.get_frame()
	var current_progress = _animated_sprite.get_frame_progress()
	_animated_sprite.play("term")
	_animated_sprite.set_frame_and_progress(current_frame, current_progress)



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var f = _animated_sprite.get_frame()
	
	if (not Globals.flipped):
		if f == 1:
			_animated_sprite.pause()
			_animated_sprite.play("term")
	else:
		if f == 0:
			_animated_sprite.pause()
			
	


func _on_button_pressed():
	
	if (Globals.flipped):
		_animated_sprite.play("flip")
	else:
		_animated_sprite.play_backwards("flip")

		
	position = Vector2(0,0)




func _on_next_pressed():
	if (Globals.flipped):
		_animated_sprite.play("flip")
	else:
		_animated_sprite.play_backwards("flip")

		
	position = Vector2(0,0)


func _on_back_pressed():
	if (Globals.flipped):
		_animated_sprite.play("flip")
	else:
		_animated_sprite.play_backwards("flip")

		
	position = Vector2(0,0)
