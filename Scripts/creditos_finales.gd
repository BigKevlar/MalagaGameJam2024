extends Control



func _on_boton_volver_pressed():
	get_tree().change_scene_to_file("res://Scenes/menu_principal.tscn")


func _on_boton_cerrar_pressed():
	get_tree().quit()
