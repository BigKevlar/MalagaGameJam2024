extends Node2D

const CENTRO_PANTALLA = Vector2(1152/2, 648/2)

@onready var texto_ouija : String= "res://Scripts/texto_ouija.txt"
var texto_ouija_array : Array = []
var eventos_array : Array = [1, 0, 1]
var posiciones_ouija_red : Array = []
var posiciones_ouija_blue : Array = []
var buscando_ouijas : bool = false
@onready var ouija_texture = $"../ouija_texture"
var nivel_finalizado : bool = false
@onready var se_al_3_er_piso = $"../señal 3er piso"

@onready var evento_index : int = 0

var ouija_red_pos : Vector2
var ouija_blue_pos : Vector2
@onready var ouija_red = $ouija_red
@onready var collision_shape_2d_red = $ouija_red/Area2DRed/CollisionShape2DRed

@onready var ouija_blue = $ouija_blue
@onready var collision_shape_2d_blue = $ouija_blue/Area2DBlue/CollisionShape2DBlue

@onready var cuadro_dialogo = get_tree().get_first_node_in_group("dialogo")
@onready var protagonista = get_tree().get_first_node_in_group("protagonista")
@onready var losetas = get_tree().get_first_node_in_group("losetas")

var tween

func _ready():
	
	var file = FileAccess.open(texto_ouija, FileAccess.READ)
	while not file.eof_reached():
		texto_ouija_array.append(file.get_line())
	texto_ouija_array.remove_at(texto_ouija_array.size()-1)
	file.close()
	
	
	var rnd = RandomNumberGenerator.new()
	for i in 3:
		
#		var pos_muerte = rnd.randi_range(0, 1)
#		eventos_array.append(pos_muerte)
		
		ouija_blue_pos.x = rnd.randi_range(100, 1000)
		ouija_blue_pos.y = rnd.randi_range(75, 500)
		ouija_red_pos.x = rnd.randi_range(100, 1000)
		ouija_red_pos.y = rnd.randi_range(75, 500)
		while ouija_blue_pos.distance_to(ouija_red_pos) <= 200:
			ouija_blue_pos.x = rnd.randi_range(100, 1000)
			ouija_blue_pos.y = rnd.randi_range(75, 500)
			ouija_red_pos.x = rnd.randi_range(100, 1000)
			ouija_red_pos.y = rnd.randi_range(75, 500)
		posiciones_ouija_blue.append(ouija_blue_pos)
		posiciones_ouija_red.append(ouija_red_pos)
	print(eventos_array)

func movimiento_ouijas():
	ouija_texture.show()
	ouija_blue.position = CENTRO_PANTALLA
	ouija_red.position = CENTRO_PANTALLA
	tween = get_tree().create_tween()
	tween.set_parallel()
	tween.tween_property(ouija_blue, "position", posiciones_ouija_blue[evento_index], 1)
	tween.tween_property(ouija_red, "position", posiciones_ouija_red[evento_index], 1)
	await get_tree().create_timer(1).timeout

func _on_area_2d_red_area_entered(area):
	if evento_index < eventos_array.size():
		if eventos_array[evento_index] == 0:
			get_tree().change_scene_to_file("res://Scenes/muerte.tscn")
		
		elif eventos_array[evento_index] == 1:
			activar_losetas()
			buscando_ouijas = false
			ouija_blue.hide()
			ouija_red.hide()
			print(texto_ouija_array)
			cuadro_dialogo.texto = []
			cuadro_dialogo.texto.append(texto_ouija_array[evento_index])
			if evento_index == 2:
				cuadro_dialogo.texto.append(texto_ouija_array[evento_index+1])
				nivel_finalizado = true
				se_al_3_er_piso.hide()
			cuadro_dialogo.abrir_dialogo()
			evento_index += 1


func _on_area_2d_blue_area_entered(area):
	if evento_index < eventos_array.size():
		if eventos_array[evento_index] == 1:
			get_tree().change_scene_to_file("res://Scenes/muerte.tscn")
		
		elif eventos_array[evento_index] == 0:
			activar_losetas()
			buscando_ouijas = false
			ouija_blue.hide()
			ouija_red.hide()
			print(texto_ouija_array)
			cuadro_dialogo.texto = []
			cuadro_dialogo.texto.append(texto_ouija_array[evento_index])
			if evento_index == 2:
				cuadro_dialogo.texto.append(texto_ouija_array[evento_index+1])
				nivel_finalizado = true
				se_al_3_er_piso.hide()
			cuadro_dialogo.abrir_dialogo()
			evento_index += 1

func desactivar_losetas():
	for i in losetas.get_children():
		i.hide()
		i.collision_shape_2d.disabled = true

func activar_losetas():
	for i in losetas.get_children():
		i.show()
		i.collision_shape_2d.disabled = false

func mostrar_ouijas():
	buscando_ouijas = true
	ouija_blue.show()
	ouija_red.show()


#func _on_final_planta_baja_area_entered(area):
#	if nivel_finalizado:
#		print("carga la siguiente escena")


func _on_area_2d_area_entered(area):
	if nivel_finalizado:
		get_tree().change_scene_to_file("res://Scenes/final_juego.tscn")
