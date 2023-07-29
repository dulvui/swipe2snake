# SPDX-FileCopyrightText: 2023 Simon Dalvai <info@simondalvai.com>

# SPDX-License-Identifier: AGPL-3.0-or-later

extends Node2D

var speed = 20

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


func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()
