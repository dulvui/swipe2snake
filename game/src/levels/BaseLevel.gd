# SPDX-FileCopyrightText: 2023 Simon Dalvai <info@simondalvai.org>

# SPDX-License-Identifier: AGPL-3.0-or-later

extends Node

@onready var points_label = $UI/Points
@onready var snake = $Actors/Snake
@onready var background = $UI/Background
@onready var timer = $Timer

var points:int = 0

var width:int
var height:int


func _ready() -> void:
	snake.wait_time = timer.wait_time


func load_level(level:Dictionary) -> void:
	height = level.blocksPositions.size()
	width = level.blocksPositions[0].size()
	
	for objects in level.blocksPositions:
		for object in objects:
			if object == 1:
				# block
				pass
			elif object == 2:
				#snake head
				pass

func _on_timer_timeout() -> void:
	snake.update()


func _on_apple_eaten() -> void:
	points += 1
	points_label.text = str(points)
	
	snake.grow()


func _on_snake_game_over() -> void:
	timer.stop()
	print("game over")
