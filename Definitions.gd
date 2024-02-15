extends ItemList

var rows = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	for i in range(len(Globals.indlistorig)):
		var notfinished = true
		var string_list = []
		var curstring = Globals.indlistorig[i]
		while notfinished:
			if not ((len(curstring) % 49 == 0) or (len(curstring) % 49 == len(curstring))):
				
				var splits = int(len(curstring) / 49)
				var notwhite = true
				var ind = 49
				while notwhite:
					if curstring[ind] != " ":
						ind -= 1
					else:
						ind += 1
						notwhite = false
						
				if len(string_list) == 0:
					string_list.append(curstring.substr(0, ind-1))
					
				curstring = curstring.substr(ind, len(curstring) % ind)
				string_list.append(curstring)
			else:
				if len(string_list) == 0:
					add_item(curstring)
					rows += 1
				notfinished = false
				for m in range(len(string_list)):
					add_item(string_list[m])
					rows += 1
					
		add_item(" ")
		rows += 1
	add_item(" ")



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
