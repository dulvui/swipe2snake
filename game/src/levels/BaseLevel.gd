# SPDX-FileCopyrightText: 2023 Simon Dalvai <info@simondalvai.com>

# SPDX-License-Identifier: AGPL-3.0-or-later

extends Node

@onready var points_label = $UI/Points
@onready var snake = $Actors/Snake
@onready var background = $UI/Background
@onready var timer = $Timer

var points:int = 0

func _ready() -> void:
	snake.wait_time = timer.wait_time


func _on_timer_timeout() -> void:
	snake.update()
#	background.update()

func _on_apple_eaten() -> void:
	points += 1
	points_label.text = str(points)
	
	snake.grow()


