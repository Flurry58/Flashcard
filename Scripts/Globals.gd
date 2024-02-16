extends Node

var filepath = ""
var flipped = false
var dontrepeat = false
var old_index = 0 #index at when the user chooses to only study stared terms
var run_change = false
var start_randomize = false
var star_only = false
var currently_stared = false
var flashcards
var put_new = false
var unset = false
var indlist = []
var indlistorig = []
var curindex = 0
var starred_list = []
var incode_list = []
var just_staring = false

var b_press = false
var n_press = false


#gives a toggle behavior to a variable
class toggle_var:
	var toggling: bool
	func _init(tog):
		toggling = tog
	
	func get_val():
		toggling = not toggling
		return toggling
#turn array into string so we can then write it to a json file 
#this is only for the list of starred terms
func array_to_string(arr: Array) -> String:
	var s = ""
	for i in arr:
		if i != "":
			s += (String(i) +",")
	return s
#recode so that there are 2 arrays, the arrray that is shuffled is made of only
#integers then map the indlist to the array of integers by indexs
func shuf(arr):
	arr.shuffle()
	for i in arr.size():
		if i == arr[i]:
			# swap this with next
			var j = (i + 1) % arr.size()
			var temp = arr[i]
			arr[i] = arr[j]
			arr[j] = temp
	return arr

	

# Called when the node enters the scene tree for the first time.
func _ready():
	var has_star = false
	var temppath = "res://assets/recent.json"
	var jsontext = FileAccess.get_file_as_string(temppath)
	var recflash = JSON.parse_string(jsontext)
	filepath = recflash["file"]
	var json_as_text = FileAccess.get_file_as_string(filepath)
	flashcards = JSON.parse_string(json_as_text)
	var i = 0
	for term in flashcards:
		if term != "*$%#%%": #represents starred
			indlistorig.append(term)
			incode_list.append(i)
		else:
			has_star = true
		i+=1
	if (not has_star):
		flashcards["*$%#%%"] = ""
	
	starred_list = flashcards["*$%#%%"].split(",")
	indlist = indlistorig.duplicate()

	

func save():
	if len(starred_list) == 0:
		flashcards["*$%#%%"] = ""
	else:
		flashcards["*$%#%%"] = array_to_string(starred_list)
	var file = FileAccess.open(filepath, FileAccess.WRITE)
	file.store_line(JSON.stringify(flashcards))
	file.close()
	
func remove_star(term):
	var inar = starred_list.find(term)
	starred_list.remove_at(inar)
	save()
	
func set_star(term):
	if term not in starred_list and term != "":
		starred_list.append(term)
		save()
	else:
		remove_star(term)

func check_empty_star():
	if len(starred_list) == 1 and starred_list[0] == "":
		return true
	else:
		return false
		
func set_recent(path):
	var plist = {"file": path}
	var file = FileAccess.open("res://assets/recent.json", FileAccess.WRITE)
	file.store_line(JSON.stringify(plist))
	file.close()
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if curindex == len(indlist):
		curindex = 0
	if start_randomize:
		if indlist == indlistorig:
			var tempind = indlist.duplicate(false)
			incode_list = shuf(incode_list)
			for i in range(len(incode_list)):
				tempind[i] = indlist[incode_list[i]-1]
			indlist = tempind
			#print(indlist)
			run_change = true
	else:
		if indlist != indlistorig:
			indlist = indlistorig.duplicate(false)
			#print(indlist)
			
	if star_only and not check_empty_star():
		
		old_index = curindex
		currently_stared = true #this is used to check if the checkbox is toggled
		#we will use this to then reset the back to the normal list when the checkbox is unclicked
		var i = 0
		indlist.clear()
		incode_list.clear()
		for term in starred_list:
			if term:
				indlist.append(term)
				incode_list.append(i)
				i+=1
		curindex = 0
		run_change = true
		star_only = false
		just_staring = true
		
	#if the starred list is empty do not activate starred as there are no starred terms to go over yet
	elif check_empty_star() and star_only:
		star_only = false
		unset = true
	#	print("Reset")
		normal_set()

#when you unclick the study starred reset the database then put index to the last index the user was at
#before they clicked the study starred button
func normal_set():
	currently_stared = false
	_ready()
	curindex = old_index
		
