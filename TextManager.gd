extends Node

var interacting = false
var speaker_name 

var text_queue = []

func change_text(speaker):
	speaker_name = speaker
	match speaker_name:
#		"ShopKeep":
#			queue_text(("Welcome to my shop"))
#			queue_text("Pick up wares while you stop.")
#			queue_text("Give me money, I am greedy.")
#			queue_text("So I beg of you, please be needy.")
		"Airdodge":
			queue_text("You have obtained the 'Air Dodge' ability!")
			queue_text("You can now dodge mid-air to travel larger distances!")
		"Prisoner":
			queue_text("Hey, you, yeah you, yeah I see you, yeah I know you're there.")
			queue_text("I need you to do me a favor, and hey, I'll give you a sweet reward if you do.")
			queue_text("Y'see, I was caught stealing candy from a baby, and now I'm down here.")
			queue_text("so do me a favor and find me the key would ya? Should be just up ahead.")
		"Prisoner_alt":
			speaker_name = "Prisoner"
			queue_text("Hey thanks chap.")
			queue_text("As for your reward..")
			queue_text("I'll open up the path forward for ya, and you should be able to pass through no problem.")
			queue_text("Not really though. This is where the demo ends.")
			queue_text("See ya!")
func queue_text(next_text):
	text_queue.push_back(next_text)
