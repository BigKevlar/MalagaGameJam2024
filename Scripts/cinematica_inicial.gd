extends Node2D

var texto_final : String = "res://Scripts/texto_cinematica_inicial.txt"
var texto_array : Array = []
@onready var cuadro_dialogo = get_tree().get_first_node_in_group("dialogo")
var texto_index : int = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	var file = FileAccess.open(texto_final, FileAccess.READ)
	while not file.eof_reached():
		texto_array.append(file.get_line())
	texto_array.remove_at(texto_array.size()-1)
	file.close()
	print(texto_array)
	cuadro_dialogo.texto = []
	cuadro_dialogo.texto = texto_array
	cuadro_dialogo.abrir_dialogo()
	
func _process(delta):
	if cuadro_dialogo.texto_finalizado:
		get_tree().change_scene_to_file("res://Scenes/escenario_1.tscn")
