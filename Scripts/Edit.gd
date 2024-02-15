extends Button


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_pressed():
	var root_node = get_tree().get_root()
	var scene_node = root_node.get_node("Home")
	scene_node.queue_free()

	# Load in some scene from our project files:
	var new_scene_resource = load("res://edit_flashcards.tscn") # Load the new level from disk
	var new_scene_node = new_scene_resource.instantiate() # Create an actual node of it for the game to use
	root_node.add_child(new_scene_node)


