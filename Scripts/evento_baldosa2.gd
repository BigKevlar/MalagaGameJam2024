extends Sprite2D

@onready var evento_iniciado : bool = false
@onready var texto_segundo_evento : String = "res://Scripts/segundo_evento.txt"
@onready var protagonista = get_tree().get_first_node_in_group("protagonista")
@onready var cuadro_dialogo = get_tree().get_first_node_in_group("dialogo")
@onready var event_manager = get_tree().get_first_node_in_group("event_manager")
var texto_array : Array = []
@onready var collision_shape_2d = $Area2D/CollisionShape2D
@onready var ouija_texture = $"../../ouija_texture"

func _ready():
	var file = FileAccess.open(texto_segundo_evento, FileAccess.READ)
	while not file.eof_reached():
		texto_array.append(file.get_line())
	texto_array.remove_at(texto_array.size()-1)
	file.close()

func _on_area_2d_area_entered(area):
	if not evento_iniciado and not event_manager.buscando_ouijas:
		event_manager.mostrar_ouijas()
		event_manager.desactivar_losetas()
		cuadro_dialogo.texto = []
		cuadro_dialogo.texto = texto_array
		cuadro_dialogo.abrir_dialogo()
		evento_iniciado = true
		
		if event_manager.evento_index < event_manager.eventos_array.size():
			event_manager.collision_shape_2d_blue.disabled = true
			event_manager.collision_shape_2d_red.disabled = true
			await event_manager.movimiento_ouijas()
			ouija_texture.hide()
			event_manager.collision_shape_2d_blue.disabled = false
			event_manager.collision_shape_2d_red.disabled = false
