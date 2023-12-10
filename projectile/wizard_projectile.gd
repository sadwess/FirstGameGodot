extends Area2D


const speed : int = 1000
var direction = Vector2.ZERO
func _ready():
	pass
func _process(delta):
	position += direction * speed * delta





func _on_body_entered(body):
	Service.emit_signal("attack",25)

