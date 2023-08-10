# SPDX-FileCopyrightText: 2023 Simon Dalvai <info@simondalvai.com>

# SPDX-License-Identifier: AGPL-3.0-or-later

extends Node2D

signal colission

const SIZE:int = 64

@export var is_head:bool = false

@onready var area_2d:Area2D = $Area2D
var direction:int

var wait_one_move:bool = true

func move(new_direction:int, time:float) -> void:
	if wait_one_move and not is_head:
		wait_one_move = false
		return
	area_2d.monitorable = true
	
	# finish tween slighty before next timeout
	# so blocks remain aligned 
	time -= 0.1

	direction = new_direction
	# create and configure tween
	var tween = create_tween()
	tween.set_ease(Tween.EASE_IN)
	tween.set_trans(Tween.TRANS_CUBIC)
	
	# actually move
	match direction:
		Global.DIRECTION.UP:
			tween.tween_property(self, "position", position + Vector2(0,-SIZE), time)
		Global.DIRECTION.DOWN:
			tween.tween_property(self, "position", position + Vector2(0,SIZE), time)
		Global.DIRECTION.LEFT:
			tween.tween_property(self, "position", position + Vector2(-SIZE,0), time)
		Global.DIRECTION.RIGHT:
			tween.tween_property(self, "position", position + Vector2(SIZE,0), time)
		_:
			pass


func _on_area_2d_area_entered(area: Area2D) -> void:
	emit_signal("colission")
