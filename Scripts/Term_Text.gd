extends RichTextLabel

var curtext = ""
var count_rep =  0
var while_limit = 0
var itercount = 0
#to avoid changing the text forever it checks if the input text is different than the text already in
#the label. If it is then change the text
#if forceoveride = true then do not check 
func put_new(text, force_overide=false):
	while_limit = len(Globals.indlist) + 5
	itercount = 0
	if len(Globals.starred_list) == 0:
		Globals.currently_stared = false
		Globals.just_staring = false
	if Globals.b_press and Globals.currently_stared:
		while Globals.indlist[Globals.curindex] not in Globals.starred_list and itercount:
			itercount += 1
			if Globals.indlist[Globals.curindex] == "*$%#%%":
				Globals.curindex = abs(Globals.curindex - 1) % (len(Globals.indlist))
			
			Globals.curindex = abs(Globals.curindex - 1) % (len(Globals.indlist))
			if itercount > while_limit:
				Globals.curindex = abs(Globals.curindex - 1) % (len(Globals.indlist))
				break
		Globals.b_press = false
		text = Globals.indlist[Globals.curindex]
	elif (Globals.n_press and Globals.currently_stared) or Globals.just_staring:
		while Globals.indlist[Globals.curindex] not in Globals.starred_list:
			itercount +=1
			if Globals.indlist[Globals.curindex] == "*$%#%%":
				Globals.curindex = abs(Globals.curindex + 1) % (len(Globals.indlist))
			Globals.curindex = abs(Globals.curindex + 1) % (len(Globals.indlist))
			if itercount > while_limit:
				Globals.curindex = abs(Globals.curindex + 1) % (len(Globals.indlist))
				break
		Globals.n_press = false
		
		text = Globals.indlist[Globals.curindex]
	if curtext != text or force_overide:
		if Globals.currently_stared:
			while Globals.indlist[Globals.curindex] not in Globals.starred_list:
				if Globals.indlist[Globals.curindex] == "*$%#%%":
					Globals.curindex = abs(Globals.curindex + 1) % (len(Globals.indlist))
				Globals.curindex = abs(Globals.curindex + 1) % (len(Globals.indlist))
			text = Globals.indlist[Globals.curindex]
		curtext = text
		clear()
		push_indent(5)
		push_color(Color("black"))
		add_text(text)
		pop()
		Globals.just_staring = false
	if get_line_count() > 7:
		set_size(Vector2(504,136))
	else:
		set_size(Vector2(496,168))
		


# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if not Globals.flipped:
		if Globals.currently_stared:
			if not Globals.check_empty_star():
				var curterm = Globals.indlist[Globals.curindex]
				put_new(curterm)
				visible = true
		else:
			var curterm = Globals.indlist[Globals.curindex]
			put_new(curterm)
			visible = true
	else:
		visible = false

	

