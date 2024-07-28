extends Control

@onready var rich_text_label = $TextureRect/RichTextLabel
var texto : Array = []
@onready var mi_archivo : String = "res://Scripts/texto_juego.txt"
var linea_archivo = -1
var terminado = true
var texto_finalizado = false
@onready var audio_stream_player = $AudioStreamPlayer
@onready var audio_stream_player_2 = $AudioStreamPlayer2

const TYPEWRITER = preload("res://Audio/efectos de sonido/typewriter.wav")
const UNTITLED = preload("res://Audio/efectos de sonido/untitled.wav")

func _ready():
	#var file = FileAccess.open(mi_archivo, FileAccess.READ)
	#while not file.eof_reached():
		#texto.append(file.get_line())
	#texto.remove_at(texto.size()-1)
	#file.close()
	pass

func _input(event):
	if event.is_action_pressed("LMB") and terminado:
		terminado = false
		limpiar_texto()
		await escribir_texto()
		terminado = true
	elif event.is_action_pressed("LMB") and not terminado:
		terminado = true
		limpiar_texto()
		terminar_texto()

func escribir_texto():
	if linea_archivo + 1 == texto.size():
		print("he cerrado el dialogo")
		cerrar_dialogo()
	else:
		linea_archivo += 1
		var i = 0
		while i < texto[linea_archivo].length() and not terminado:
			rich_text_label.text += texto[linea_archivo][i]
			audio_stream_player.stream = TYPEWRITER
			audio_stream_player.play()
			await get_tree().create_timer(0.1).timeout
			i += 1

func limpiar_texto():
	audio_stream_player_2.stream = UNTITLED
	audio_stream_player_2.play()
	rich_text_label.text = ""
	rich_text_label.bbcode_text = "[shake rate=15.0 level=2 connected=1]"

func terminar_texto():
	rich_text_label.text += texto[linea_archivo]

func abrir_dialogo():
	get_tree().paused = true
	texto_finalizado = false
	show()
	terminado = false
	await escribir_texto()
	terminado = true

func cerrar_dialogo():
	linea_archivo = -1
	get_tree().paused = false
	texto_finalizado = true
	hide()
