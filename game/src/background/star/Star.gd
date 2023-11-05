# SPDX-FileCopyrightText: 2023 Simon Dalvai <info@simondalvai.org>

# SPDX-License-Identifier: AGPL-3.0-or-later

extends Node2D

signal exit_screen

const OFFSET:int = 40

var speed:int = 80

var inside_screen:bool = false

func _ready() -> void:
	# random alpha
	modulate = Color(1,1,1,randf_range(0.4, 0.9))

func _process(delta: float) -> void:
	match Global.direction:
		Global.DIRECTION.UP, Global.DIRECTION.NONE:
			position += Vector2(0, speed) * delta
		Global.DIRECTION.DOWN:
			position += Vector2(0, -speed) * delta
		Global.DIRECTION.LEFT:
			position += Vector2(speed,0) * delta
		Global.DIRECTION.RIGHT:
			position += Vector2(-speed,0) * delta


func _on_visible_on_screen_notifier_2d_screen_entered() -> void:
	inside_screen = true

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	if inside_screen:
		emit_signal("exit_screen")
		queue_free()
	
func set_random_position(inside_screen:bool=false) -> void:
	if inside_screen:
		position = Vector2(randi_range(0, Global.WIDHT), randi_range(0, Global.HEIGHT))
	else:
		match Global.direction:
			Global.DIRECTION.UP, Global.DIRECTION.NONE:
				position = Vector2(randi_range(0, Global.WIDHT), -OFFSET)
			Global.DIRECTION.DOWN:
				position = Vector2(randi_range(0, Global.WIDHT), Global.HEIGHT + OFFSET)
			Global.DIRECTION.LEFT:
				position = Vector2(0 - OFFSET, randi_range(0, Global.HEIGHT))
			Global.DIRECTION.RIGHT:
				position = Vector2(Global.WIDHT + OFFSET, randi_range(0, Global.HEIGHT))

