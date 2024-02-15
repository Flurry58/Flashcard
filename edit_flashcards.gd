extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Globals.put_new:
		var vec = $Terms.get_item_rect($Terms.rows).position
		$new_set.position = Vector2($new_set.position[0], vec[1]+10)
		$Add_term.position = Vector2($Add_term.position[0], vec[1]+34)
		$Add_def.position = Vector2($Add_def.position[0], vec[1]+34)
		Globals.put_new = false

func _on_new_set_pressed():
	var vec = $Terms.get_item_rect($Terms.rows).position
	$new_set.position = Vector2($new_set.position[0], vec[1]+10)
	$Add_term.position = Vector2($Add_term.position[0], vec[1]+34)
	$Add_def.position = Vector2($Add_def.position[0], vec[1]+34)
