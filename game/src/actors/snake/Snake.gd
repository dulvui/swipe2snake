# SPDX-FileCopyrightText: 2023 Simon Dalvai <info@simondalvai.com>

# SPDX-License-Identifier: AGPL-3.0-or-later

extends Node2D

enum DIRECTION {UP, DOWN, NONE, LEFT, RIGHT}

const SIZE:int = 64

var direction:int = DIRECTION.NONE
var direction_buffer:Array = []

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("move_up"):
		_add_to_buffer(DIRECTION.UP)
	elif event.is_action_pressed("move_down"):
			_add_to_buffer(DIRECTION.DOWN)
	elif event.is_action_pressed("move_left"):
		_add_to_buffer(DIRECTION.LEFT)
	elif event.is_action_pressed("move_right"):
		_add_to_buffer(DIRECTION.RIGHT)

func _on_timer_timeout() -> void:
	_move()

func _move() -> void:
	# check buffer for new direction
	if not direction_buffer.is_empty():
		direction = direction_buffer.pop_front()
	
	# create and configure tween
	var tween = create_tween()
	tween.set_ease(Tween.EASE_IN)
	tween.set_trans(Tween.TRANS_CUBIC)
	
	# actually move
	match direction:
		DIRECTION.UP:
			tween.tween_property(self, "position", position + Vector2(0,-SIZE), 1)
		DIRECTION.DOWN:
			tween.tween_property(self, "position", position + Vector2(0,SIZE), 1)
		DIRECTION.LEFT:
			tween.tween_property(self, "position", position + Vector2(-SIZE,0), 1)
		DIRECTION.RIGHT:
			tween.tween_property(self, "position", position + Vector2(SIZE,0), 1)
		_:
			pass
	

func _add_to_buffer(new_direction:int) -> void:
	if _is_valid_direction(new_direction):
		direction_buffer.append(new_direction)
	

func _is_valid_direction(new_direction:int) -> bool:
	# up = 0, down = 1, none = 2, left = 3, right = 4
	# up - down = -1
	# down - up = 1
	# down - down = 0
	# => valid move is > 1
	if direction_buffer.size() == 0:
		return abs(new_direction - direction) > 1
	return abs(new_direction - direction_buffer[-1]) > 1
