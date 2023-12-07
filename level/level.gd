extends Node2D






func _process(_delta):
		print($player.position.distance_to($Spawns/M1.position))
	


func _on_player_shoot(pos,dir):
	var laser = preload("res://projectile/projectile.tscn").instantiate() as Area2D
	laser.position = pos
	laser.rotation_degrees = rad_to_deg(dir.angle()) 
	laser.direction = dir
	$".".add_child(laser)
