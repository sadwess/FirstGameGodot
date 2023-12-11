extends CanvasLayer



func _ready():
	Input.set_custom_mouse_cursor(load("res://mouse.png"))
func _on_play_pressed():
	get_tree().change_scene_to_file("res://level/level.tscn")
	
func _on_quit_pressed():
	get_tree().quit()
