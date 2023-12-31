# SPDX-FileCopyrightText: 2023 Simon Dalvai <info@simondalvai.org>

# SPDX-License-Identifier: AGPL-3.0-or-later

extends Node2D

signal eaten

var enabled:bool = true

func _on_area_2d_area_entered(area: Area2D) -> void:
	if enabled:
		enabled = false
		emit_signal("eaten")
		
		var tween = create_tween()
		tween.set_ease(Tween.EASE_IN)
		tween.set_trans(Tween.TRANS_CUBIC)
		tween.tween_property(self, "scale", Vector2(0,0), 1)
		tween.tween_callback(queue_free)
