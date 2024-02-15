extends RichTextLabel

var curtext = ""
func put_new(text, force_overide=false):
	if curtext != text or force_overide:
		curtext = text
		clear()
		push_indent(5)
		push_color(Color("black"))
		add_text(text)
		pop()
	if get_line_count() > 7:
		set_size(Vector2(504,168))
	else:
		set_size(Vector2(496,168))

# Called when the node enters the scene tree for the first time.
func _ready():
	clear()
	push_indent(5)
	push_color(Color("black"))
	add_text("Goodbye")
	pop() # Replace with function body.


func manual_change():
	var curterm = Globals.indlist[Globals.curindex]
	put_new(Globals.flashcards[curterm])
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Globals.flipped:
		var curterm = Globals.indlist[Globals.curindex]
		put_new(Globals.flashcards[curterm])	
		visible = true
	else:
		visible = false

