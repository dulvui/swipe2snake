# SPDX-FileCopyrightText: 2023 Simon Dalvai <info@simondalvai.com>

# SPDX-License-Identifier: AGPL-3.0-or-later

extends Node2D

signal game_over

const Body:PackedScene = preload("res://src/actors/snake/body/Body.tscn")


@onready var timer = $Timer 
@onready var head = $Head 


var direction_buffer:Array = []

var is_growing = false

var bodies:Array = []

var wait_time:float = 0

func update() -> void:
	if is_growing:
		is_growing = false
		var block:Node2D = Body.instantiate()
		if bodies.size() > 0:
			block.position = bodies[-1].position
		else:
			block.position = head.position
		bodies.append(block)
		add_child(block)
	_move()

func grow():
	is_growing = true

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("move_up"):
		_add_to_buffer(Global.DIRECTION.UP)
	elif event.is_action_pressed("move_down"):
		_add_to_buffer(Global.DIRECTION.DOWN)
	elif event.is_action_pressed("move_left"):
		_add_to_buffer(Global.DIRECTION.LEFT)
	elif event.is_action_pressed("move_right"):
		_add_to_buffer(Global.DIRECTION.RIGHT)
	

func _move() -> void:
	if bodies.size() > 0:
		# last block moves in last -1 block direction etc...
		var i = bodies.size() -1
		while i > 0:
			bodies[i].move(bodies[i - 1].direction, wait_time)
			i -= 1
		
		bodies[0].move(Global.direction, wait_time)
	
		# check buffer for new direction
	if not direction_buffer.is_empty():
		Global.direction = direction_buffer.pop_front()
	
	head.move(Global.direction, wait_time)



func _add_to_buffer(new_direction:int) -> void:
	if _is_valid_direction(new_direction):
		direction_buffer.append(new_direction)
	

func _is_valid_direction(new_direction:int) -> bool:
	if Global.direction == Global.DIRECTION.NONE:
		return true

	# up = 0, down = 1, none = 2, left = 3, right = 4
	# up - down = -1
	# down - up = 1
	# down - down = 0
	# => valid move is > 1
	if direction_buffer.size() == 0:
		return abs(new_direction - Global.direction) > 1
	return abs(new_direction - direction_buffer[-1]) > 1


func _on_head_colission() -> void:
	emit_signal("game_over")
