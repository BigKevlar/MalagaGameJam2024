extends Node2D

const CENTRO_PANTALLA = Vector2(0, 0)

var eventos_array : Array = []
var posiciones_ouija_red : Array = []
var posiciones_ouija_blue : Array = []

@onready var evento_index : int = 0

var ouija_red_pos : Vector2
var ouija_blue_pos : Vector2
@onready var ouija_red = $ouija_red
@onready var collision_shape_2d_red = $ouija_red/Area2DRed/CollisionShape2DRed

@onready var ouija_blue = $ouija_blue
@onready var collision_shape_2d_blue = $ouija_blue/Area2DBlue/CollisionShape2DBlue

@onready var cuadro_dialogo = get_tree().get_first_node_in_group("dialogo")

@onready var protagonista = get_tree().get_first_node_in_group("protagonista")

var tween

func _ready():
	var rnd = RandomNumberGenerator.new()
	for i in 3:
		
		var pos_muerte = rnd.randi_range(0, 1)
		eventos_array.append(pos_muerte)
		
		ouija_blue_pos.x = rnd.randi_range(-500, 500)
		ouija_blue_pos.y = rnd.randi_range(-250, 250)
		ouija_red_pos.x = rnd.randi_range(-500, 500)
		ouija_red_pos.y = rnd.randi_range(-250, 250)
		while ouija_blue_pos.distance_to(ouija_red_pos) <= 100:
			ouija_blue_pos.x = rnd.randi_range(-500, 500)
			ouija_blue_pos.y = rnd.randi_range(-250, 250)
			ouija_red_pos.x = rnd.randi_range(-500, 500)
			ouija_red_pos.y = rnd.randi_range(-250, 250)
		posiciones_ouija_blue.append(ouija_blue_pos)
		posiciones_ouija_red.append(ouija_red_pos)
	print(eventos_array)
	
	collision_shape_2d_blue.disabled = true
	collision_shape_2d_red.disabled = true
	print("desactivado")
	await movimiento_ouijas()
	collision_shape_2d_blue.disabled = false
	collision_shape_2d_red.disabled = false
	print("activado")

func movimiento_ouijas():
	ouija_blue.position = CENTRO_PANTALLA
	ouija_red.position = CENTRO_PANTALLA
	tween = get_tree().create_tween()
	tween.set_parallel()
	tween.tween_property(ouija_blue, "position", posiciones_ouija_blue[evento_index], 1)
	tween.tween_property(ouija_red, "position", posiciones_ouija_red[evento_index], 1)
	await get_tree().create_timer(1).timeout

func _on_area_2d_red_area_entered(area):
	if area == protagonista.area_2d:
		if evento_index < eventos_array.size():
			if eventos_array[evento_index] == 0:
				print("has muerto")
			
			elif eventos_array[evento_index] == 1:
				cuadro_dialogo.texto = []
				cuadro_dialogo.texto.append("mala noticia")
				cuadro_dialogo.abrir_dialogo()
				evento_index += 1
				if evento_index < eventos_array.size():
					collision_shape_2d_blue.disabled = true
					collision_shape_2d_red.disabled = true
					await movimiento_ouijas()
					collision_shape_2d_blue.disabled = false
					collision_shape_2d_red.disabled = false


func _on_area_2d_blue_area_entered(area):
	if area == protagonista.area_2d:
		if evento_index < eventos_array.size():
			if eventos_array[evento_index] == 1:
				print("has muerto")
			
			elif eventos_array[evento_index] == 0:
				cuadro_dialogo.texto = []
				cuadro_dialogo.texto.append("mala noticia")
				cuadro_dialogo.abrir_dialogo()
				evento_index += 1
				if evento_index < eventos_array.size():
					collision_shape_2d_blue.disabled = true
					collision_shape_2d_red.disabled = true
					await movimiento_ouijas()
					collision_shape_2d_blue.disabled = false
					collision_shape_2d_red.disabled = false
					
