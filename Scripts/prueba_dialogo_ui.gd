extends Control

@onready var rich_text_label = $TextureRect/RichTextLabel
var texto : Array = ["malagajam", "tengo otro texto que mostrarte..."]
var texto_index = -1
var terminado = true

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
	texto_index += 1
	var i = 0
	while i < texto[texto_index].length() and not terminado:
		rich_text_label.text += texto[texto_index][i]
		await get_tree().create_timer(0.1).timeout
		i += 1

func limpiar_texto():
	rich_text_label.text = ""
	rich_text_label.bbcode_text = "[shake rate=15.0 level=2 connected=1]"

func terminar_texto():
	rich_text_label.text += texto[texto_index]
