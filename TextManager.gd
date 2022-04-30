extends Node

var interacting = false
var speaker_name 

var text_queue = []

func change_text(speaker):
	speaker_name = speaker
	match speaker_name:
		"ShopKeep":
			queue_text(("Welcome to my shop"))
			queue_text("Pick up wares while you stop.")
			queue_text("Give me money, I am greedy.")
			queue_text("So I beg of you, please be needy.")
		"Airdodge":
			queue_text("You have obtained the 'Air Dodge' ability!")
			queue_text("You can now dodge mid-air to travel larger distances!")

func queue_text(next_text):
	text_queue.push_back(next_text)
