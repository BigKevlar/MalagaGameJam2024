extends Node2D

@onready var animated_sprite_2d = $protagonista/AnimatedSprite2D


func _input(event):
	if event.is_action_released("Left"):
		animated_sprite_2d.play("move_left")
