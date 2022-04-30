extends Control

var page_num = 0

onready var rightP = $RightPage
onready var leftP = $LeftPage

var entry_left = JournalEntries.entry_left

var entry_right = JournalEntries.entry_right
var open = false



func _ready():
	turn_page(0)

func _process(delta):
	if Input.is_action_just_pressed("Journal"):
		if open:
			open = false
			visible = false
		else:
			open = true
			visible = true
	
	if open:
		if Input.is_action_just_pressed("ui_right"):
			turn_page(page_num + 1)
			if page_num > 20:
				page_num = 20
		if Input.is_action_just_pressed("ui_left"):
			turn_page(page_num - 1)
			if page_num < -1:
				page_num = -1
	else:
		visible = false


func turn_page(page):
	page_num = page
	match page_num:
		-1:
			leftP.text = ""
			rightP.text = "Easter Egg"
		0:
			leftP.text = entry_left[0]
			rightP.text = entry_right[0]
		1:
			leftP.text = entry_left[1]
			rightP.text = entry_right[1]
		2:
			leftP.text = entry_left[2]
			rightP.text = entry_right[2]
		3:
			leftP.text = entry_left[3]
			rightP.text = entry_right[3]
		4:
			leftP.text = entry_left[4]
			rightP.text = entry_right[4]
		5:
			leftP.text = entry_left[5]
			rightP.text = entry_right[5]
		6:
			leftP.text = entry_left[6]
			rightP.text = entry_right[6]
		7:
			leftP.text = entry_left[7]
			rightP.text = entry_right[7]
		8:
			leftP.text = entry_left[8]
			rightP.text = entry_right[8]
		9:
			leftP.text = entry_left[9]
			rightP.text = entry_right[9]
