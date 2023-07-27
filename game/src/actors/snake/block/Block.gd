# SPDX-FileCopyrightText: 2023 Simon Dalvai <info@simondalvai.com>

# SPDX-License-Identifier: AGPL-3.0-or-later

extends Node2D

enum DIRECTION {UP, DOWN, NONE, LEFT, RIGHT}

const SIZE:int = 64

var direction:int

var wait_one_move:bool = true

func move(new_direction:int, time:float) -> void:
	if wait_one_move:
		wait_one_move = false
		return

	direction = new_direction
	# create and configure tween
	var tween = create_tween()
	tween.set_ease(Tween.EASE_IN)
	tween.set_trans(Tween.TRANS_CUBIC)
	
	# actually move
	match direction:
		DIRECTION.UP:
			tween.tween_property(self, "position", position + Vector2(0,-SIZE), time)
		DIRECTION.DOWN:
			tween.tween_property(self, "position", position + Vector2(0,SIZE), time)
		DIRECTION.LEFT:
			tween.tween_property(self, "position", position + Vector2(-SIZE,0), time)
		DIRECTION.RIGHT:
			tween.tween_property(self, "position", position + Vector2(SIZE,0), time)
		_:
			pass


func _on_area_2d_area_entered(area: Area2D) -> void:
	pass # Replace with function body.
