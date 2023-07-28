# SPDX-FileCopyrightText: 2023 Simon Dalvai <info@simondalvai.com>

# SPDX-License-Identifier: AGPL-3.0-or-later

extends Node2D

const Block:PackedScene = preload("res://src/actors/snake/block/Block.tscn")


@onready var timer = $Timer 
@onready var head = $Head 


var direction:int = Constants.DIRECTION.NONE
var direction_buffer:Array = []

var is_growing = false

var body:Array = []

var wait_time:float = 0

func update() -> void:
	if is_growing:
		is_growing = false
		var block:Node2D = Block.instantiate()
		if body.size() > 0:
			block.position = body[-1].position
		else:
			block.position = head.position
		body.append(block)
		add_child(block)
	_move()

func grow():
	is_growing = true

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("move_up"):
		_add_to_buffer(Constants.DIRECTION.UP)
	elif event.is_action_pressed("move_down"):
			_add_to_buffer(Constants.DIRECTION.DOWN)
	elif event.is_action_pressed("move_left"):
		_add_to_buffer(Constants.DIRECTION.LEFT)
	elif event.is_action_pressed("move_right"):
		_add_to_buffer(Constants.DIRECTION.RIGHT)
	

func _move() -> void:
	if body.size() > 0:
		# last block moves in last -1 block direction etc...
		var i = body.size() -1
		while i > 0:
			body[i].move(body[i - 1].direction, wait_time)
			i -= 1
		
		body[0].move(direction, wait_time)
	
		# check buffer for new direction
	if not direction_buffer.is_empty():
		direction = direction_buffer.pop_front()
	
	head.move(direction, wait_time)



func _add_to_buffer(new_direction:int) -> void:
	if _is_valid_direction(new_direction):
		direction_buffer.append(new_direction)
	

func _is_valid_direction(new_direction:int) -> bool:
	if direction == Constants.DIRECTION.NONE:
		return true

	# up = 0, down = 1, none = 2, left = 3, right = 4
	# up - down = -1
	# down - up = 1
	# down - down = 0
	# => valid move is > 1
	if direction_buffer.size() == 0:
		return abs(new_direction - direction) > 1
	return abs(new_direction - direction_buffer[-1]) > 1
