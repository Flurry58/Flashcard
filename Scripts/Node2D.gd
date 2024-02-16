extends Node2D

@onready var _animated_sprite = $AnimatedSprite2D
# Called when the node enters the scene tree for the first time.
func _ready():
	var current_frame = _animated_sprite.get_frame()
	var current_progress = _animated_sprite.get_frame_progress()
	_animated_sprite.play("term")
	_animated_sprite.set_frame_and_progress(current_frame, current_progress)




func _on_button_pressed():
	if not Globals.dontrepeat:
		if (Globals.flipped):
			_animated_sprite.play("term")
			_animated_sprite.set_frame_and_progress(0, 0)
			_animated_sprite.pause()		
		else:
			_animated_sprite.play_backwards("flip")
			_animated_sprite.set_frame_and_progress(0, 0)
			_animated_sprite.pause()
			
		Globals.flipped = not Globals.flipped
		position = Vector2(0,0)
	else:
		Globals.dontrepeat = false




func _on_next_pressed():
	if (Globals.flipped):
		_animated_sprite.play("term")
		_animated_sprite.set_frame_and_progress(0, 0)
		_animated_sprite.pause()		
	else:
		_animated_sprite.play_backwards("flip")
		_animated_sprite.set_frame_and_progress(0, 0)
		_animated_sprite.pause()

		
	position = Vector2(0,0)


func _on_back_pressed():
	if (Globals.flipped):
		_animated_sprite.play("term")
		_animated_sprite.set_frame_and_progress(0, 0)
		_animated_sprite.pause()		
	else:
		_animated_sprite.play_backwards("flip")
		_animated_sprite.set_frame_and_progress(0, 0)
		_animated_sprite.pause()

		

		
	position = Vector2(0,0)
