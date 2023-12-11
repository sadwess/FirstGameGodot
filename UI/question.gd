extends CanvasLayer

var questions : Array
var question
func _ready():
	Input.set_custom_mouse_cursor(load("res://mouse.png"))
	questions = getData()
	question = questions[randi_range(0,questions.size())]
	$Cadre/Label3.text = question["question"]
	$Cadre/TextureButton/b1.text = question["options"][0]
	$Cadre/TextureButton2/b2.text = question["options"][1]
	$Cadre/TextureButton3/b3.text = question["options"][2]
	$Cadre/TextureButton4/b4.text = question["options"][3]
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
func getData():
	var gdscript_array = []
	var data = FileAccess.open("res://questions.json",FileAccess.READ)
	var parseData = JSON.parse_string(data.get_as_text())
	for entry in parseData["questions"]:
		var gdscript_dict = {
		"question": entry["question"],
		"options": entry["options"],
		"correct_answer_index": entry["correct_answer_index"]
	}
		gdscript_array.append(gdscript_dict)
	return gdscript_array
func checkAnswer(label : Label):
	if label.text == question["options"][question["correct_answer_index"]]:
		Service.emit_signal("respawn")
		queue_free()
	else:
		get_tree().change_scene_to_file("res://UI/menu.tscn")
func _on_texture_button_pressed():
	checkAnswer($Cadre/TextureButton/b1)
	
func _on_texture_button_2_pressed():
	checkAnswer($Cadre/TextureButton2/b2)
	
func _on_texture_button_3_pressed():
	checkAnswer($Cadre/TextureButton3/b3)

func _on_texture_button_4_pressed():
	checkAnswer($Cadre/TextureButton4/b4)
