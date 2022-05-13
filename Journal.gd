extends Control

var page_num = 0

onready var rightP = $RightPage
onready var leftP = $LeftPage

var entry_left = JournalEntries.entry_left
var entry_right = JournalEntries.entry_right
var open = false



func _ready():
	turn_page(-2)

func _process(delta):
	entry_left = JournalEntries.entry_left
	entry_right = JournalEntries.entry_right
	$Right_num.text = str(page_num + 2)
	if page_num <= -2:
		$Left_num.text = ""
	else:
		$Left_num.text = str(page_num + 1)
	if Input.is_action_just_pressed("Journal"):
		if open:
			open = false
			visible = false
		else:
			turn_page(page_num)
			open = true
			visible = true
	
	if open:
		if Input.is_action_just_pressed("ui_right") || $PageRight.pressed:
			turn_page(page_num + 2)
			if page_num > 20:
				page_num = 20
		if Input.is_action_just_pressed("ui_left") || $PageLeft.pressed:
			turn_page(page_num - 2)
			if page_num < -4:
				page_num = -4
	else:
		visible = false


func turn_page(page):
	page_num = page
	match page_num:
		-4:
			leftP.text = ""
			rightP.text = "Easter Egg"
		-2:
			leftP.text = entry_left[0]
			rightP.text = entry_right[0]
		0:
			leftP.text = entry_left[1]
			rightP.text = entry_right[1]
		2:
			leftP.text = entry_left[2]
			rightP.text = entry_right[2]
		4:
			leftP.text = entry_left[3]
			rightP.text = entry_right[3]
		6:
			leftP.text = entry_left[4]
			rightP.text = entry_right[4]
		8:
			leftP.text = entry_left[5]
			rightP.text = entry_right[5]
		10:
			leftP.text = entry_left[6]
			rightP.text = entry_right[6]
		12:
			leftP.text = entry_left[7]
			rightP.text = entry_right[7]
		14:
			leftP.text = entry_left[8]
			rightP.text = entry_right[8]
		16:
			leftP.text = entry_left[9]
			rightP.text = entry_right[9]
