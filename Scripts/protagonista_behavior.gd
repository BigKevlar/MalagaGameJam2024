extends Node2D

@onready var animated_sprite_2d = $protagonista/AnimatedSprite2D

func _physics_process(delta):
	if Input.is_action_pressed("Left"):
		position.x -= 1
	if Input.is_action_pressed("Right"):
		position.x += 1
	if Input.is_action_pressed("Down"):
		position.y += 1
	if Input.is_action_pressed("Up"):
		position.y -= 1

func _input(event):
	if event.is_action_pressed("Left"):
		animated_sprite_2d.play("move_left")
	
	if event.is_action_pressed("Right"):
		animated_sprite_2d.play("move_right")
	
	if event.is_action_pressed("Down"):
		animated_sprite_2d.play("move_down")
	
	if event.is_action_pressed("Up"):
		animated_sprite_2d.play("move_up")
	
	if event.is_action_released("Left") or event.is_action_released("Right") or event.is_action_released("Down") or event.is_action_released("Up"):
		animated_sprite_2d.stop()
