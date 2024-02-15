extends Sprite2D


# Called when the node enters the scene tree for the first time.
func _ready():
	var image = Image.load_from_file("res://assets/image2vector.svg")
	var texture = ImageTexture.create_from_image(image)
	$Sprite2D.texture = texture


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
