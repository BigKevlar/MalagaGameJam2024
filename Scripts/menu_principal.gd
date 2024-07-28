extends Control

@onready var boton_empezar = $boton_empezar

func _on_boton_empezar_pressed():
	get_tree().change_scene_to_file("res://Scenes/cinematica_inicial.tscn")
