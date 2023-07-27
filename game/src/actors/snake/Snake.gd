# SPDX-FileCopyrightText: 2023 Simon Dalvai <info@simondalvai.com>

# SPDX-License-Identifier: AGPL-3.0-or-later

extends Node2D

const Block:PackedScene = preload("res://src/actors/snake/block/Block.tscn")

enum DIRECTION {UP, DOWN, NONE, LEFT, RIGHT}

@onready var timer = $Timer 
@onready var head = $Head 


var direction:int = DIRECTION.NONE
var direction_buffer:Array = []

var body:Array = []

func grow():
	var block:Node2D = Block.instantiate()
	block.position = position
	body.append(block)
	add_child(block)

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
	_move_body()
	_move_head()
	

func _move_head() -> void:
	# check buffer for new direction
	if not direction_buffer.is_empty():
		direction = direction_buffer.pop_front()
	
	head.move(direction, timer.wait_time)

			
func _move_body() -> void:
	if body.size() == 0:
		return

	body[0].move(direction, timer.wait_time)
	
	var i = 1
	while i < body.size():
		body[i].move(body[i - 1].direction, timer.wait_time)


func _add_to_buffer(new_direction:int) -> void:
	if _is_valid_direction(new_direction):
		direction_buffer.append(new_direction)
	

func _is_valid_direction(new_direction:int) -> bool:
	if direction == DIRECTION.NONE:
		return true

	# up = 0, down = 1, none = 2, left = 3, right = 4
	# up - down = -1
	# down - up = 1
	# down - down = 0
	# => valid move is > 1
	if direction_buffer.size() == 0:
		return abs(new_direction - direction) > 1
	return abs(new_direction - direction_buffer[-1]) > 1
