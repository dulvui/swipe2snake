# SPDX-FileCopyrightText: 2023 Simon Dalvai <info@simondalvai.com>

# SPDX-License-Identifier: AGPL-3.0-or-later

extends Control

@onready var exit_dialog:ConfirmationDialog = $ExitDialog

func _on_play_pressed() -> void:
	get_tree().change_scene_to_file("res://src/screens/level-choose/LevelChoose.tscn")


func _on_exit_pressed() -> void:
	exit_dialog.show()


func _on_exit_dialog_confirmed() -> void:
	get_tree().quit()

# save on quit on mobile
func _notification(what) -> void:
	if what == NOTIFICATION_WM_CLOSE_REQUEST:
#		save_all_data()
		get_tree().quit() # default behavior


func _on_exit_dialog_canceled() -> void:
	exit_dialog.hide()
