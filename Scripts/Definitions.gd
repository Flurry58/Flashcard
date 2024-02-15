extends Label

func put_new(text):
	clear()
	push_color(Color("black"))
	add_text(text)
	pop()

# Called when the node enters the scene tree for the first time.
func _ready():
	clear()
	push_color(Color("black"))
	add_text("Goodbye")
	pop() # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Globals.flipped:
		var curterm = Globals.indlist[Globals.curindex]
		put_new(Globals.flashcards[curterm])
		
		visible = true
	else:
		visible = false
