extends Control

var loading_json = false
var loading_csv = false
var loading_tsv = false
var json_as_text
var flash
var file
var text_json
var has_star
var i

func _on_menu_item_pressed(path, popup_menu, item_index, section_indices):
	match(path):
		# Note the option to leave out data that is not relevant.
		"Load/Json" : load_json() 
		"Load/CSV" : load_csv()
		"Load/TSV" : load_tsv()

func load_json():
	loading_json = true
	$FileDialog.visible = true
	
func load_csv():
	loading_csv = true
	$FileDialog.visible = true
	
func load_tsv():
	loading_tsv = true
	$FileDialog.visible = true

func check_file(path):
	var text_json = FileAccess.get_file_as_string(path)
	if loading_csv:
		text_json = process_csv(text_json)
		
		loading_csv = false
	elif loading_tsv:
		text_json = process_tsv(text_json)
		loading_tsv = false
	else:
		text_json = JSON.parse_string(text_json)
	return text_json

func getrange(int1, int2, data):
	var string1 = ""
	for i in range(int1, int2):
		if data[i] != "	" and data[i] != "\n":
			string1 += data[i]
	return string1


func check_newline(string_input, to_search):
	var regex = RegEx.new()
	regex.compile(string_input)
	var result = regex.search(to_search)

	if result:
		return true
	
	return false
	
func process_tsv(data):
	var data_json = {}
	var p1 = ''
	var p2 = ''
	var begin_t = 0
	var curchar_newline = false
	var end_t = 0
	var firstdone = false
	for i in range(len(data)):
		curchar_newline = check_newline("/\r\n|\r|\n/", data[i])
		if data[i] == "	" and not firstdone :	
			end_t = i
			
			p1= getrange(begin_t, end_t, data)
			begin_t = i
			if p1:
				firstdone = true
		
		elif curchar_newline and firstdone:
			end_t = i
			p2 = getrange(begin_t, end_t, data)
			data_json[p1] = p2
			begin_t = i+1
			p1 = ""
			p2 = ""
			firstdone = false
			
	return data_json
		

	
		
			
	
func process_csv(data):
	pass

func _on_file_dialog_file_selected(path):
	flash = check_file(path)

	
	file = FileAccess.open("res://assets/file.json", FileAccess.WRITE)
	file.store_line(JSON.stringify(flash))
	file.close()
	
	$FileDialog.visible = false
	Globals.curindex = 0
	Globals.indlist = []
	Globals.indlistorig = []
	Globals.incode_list = []
	has_star = false
	
	i = 0
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


func _on_file_dialog_canceled():
	$FileDialog.visible = false

