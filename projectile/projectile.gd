extends Area2D


const speed : int = 1000
var direction = Vector2.ZERO
func _ready():
	$AnimationPlayer.play("launch")
func _process(delta):
	position += direction * speed * delta





func _on_body_entered(body):
	if "hit" in body:
		body.hit()
	queue_free()
