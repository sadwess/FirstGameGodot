extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$EnemiesCounter/VBoxContainer/Label.text = str(Service.monstersCount)
	$Health/HealthBar.value =Service.playerHealth
	$Health/VBoxContainer2/score.text = str(Service.score) + " Score"
