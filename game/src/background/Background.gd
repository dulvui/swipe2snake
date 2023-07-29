# SPDX-FileCopyrightText: 2023 Simon Dalvai <info@simondalvai.com>

# SPDX-License-Identifier: AGPL-3.0-or-later

extends Control

const Star:PackedScene = preload("res://src/background/star/Star.tscn")

const MAX_STARS = 40

var stars:Array = []


func _ready() -> void:
	for i in MAX_STARS:
		var star = Star.instantiate()
		star.set_random_position(true)
		star.exit_screen.connect(_new_star)
		add_child(star)

func _new_star(inside_screen:bool=false) -> void:
	var star = Star.instantiate()
	star.set_random_position()
	star.exit_screen.connect(_new_star)
	add_child(star)
