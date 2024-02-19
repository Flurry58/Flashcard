extends Button



# Called when the node enters the scene tree for the first time.
func _ready():
	$Quiz.visible = false



func _on_pressed():
	$FileDialog.visible = true
	$Quiz.visible = true



func _on_file_dialog_canceled():
	$FileDialog.visible = false
	$Quiz.visible = false
	

#when file selected open file and load it 

func _on_file_dialog_file_selected(path):
	var json_as_text = FileAccess.get_file_as_string(path)
	
	var flash = JSON.parse_string(json_as_text)
	
	var file = FileAccess.open("res://assets/file.json", FileAccess.WRITE)
	file.store_line(JSON.stringify(flash))
	file.close()
	
	
	
	$FileDialog.visible = false
	$Quiz.visible = false
	Globals.curindex = 0
	Globals.indlist = []
	Globals.indlistorig = []
	Globals.incode_list = []
	var has_star = false
	var i = 0


	for term in flash:
		if term != "*$%#%%": #represents starred
			Globals.indlistorig.append(term)
			Globals.incode_list.append(i)
		else:
			has_star = true
		i+=1
	if (not has_star):
		flash["*$%#%%"] = ""
	
	Globals.starred_list = flash["*$%#%%"].split(",")
	Globals.indlist = Globals.indlistorig.duplicate()
	Globals.flashcards = flash
	Globals.run_change = true
	
