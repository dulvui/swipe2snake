# SPDX-FileCopyrightText: 2023 Simon Dalvai <info@simondalvai.com>

# SPDX-License-Identifier: AGPL-3.0-or-later

extends Node2D

@onready var points_label = $Points
@onready var snake = $Snake

var points:int = 0



func _on_apple_eaten() -> void:
	points += 1
	points_label.text = str(points)
	
	snake.grow()
