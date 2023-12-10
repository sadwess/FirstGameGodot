extends Node2D

var skeleton = preload("res://Enemies/skeleton.tscn")
var demon = preload("res://Enemies/demon.tscn")
var wizard = preload("res://Enemies/wizard.tscn")
@onready var monsters = [skeleton,demon,wizard]
func _ready():
	
	Service.connect("wizardAttack",on_wizard_shoot)

func _process(_delta):
	pass


func _on_player_shoot(pos,dir):
	var laser = preload("res://projectile/projectile.tscn").instantiate() as Area2D
	laser.position = pos
	laser.rotation_degrees = rad_to_deg(dir.angle()) 
	laser.direction = dir
	$".".add_child(laser)
func on_wizard_shoot(pos,dir):
	print("z")
	var wP = preload("res://projectile/wizard_projectile.tscn").instantiate() as Area2D
	wP.position = pos
	wP.rotation_degrees = rad_to_deg(dir.angle()) 
	wP.direction = dir
	$".".add_child(wP)
func spanwRandom():
	var monster = monsters[randi_range(0,2)].instantiate() as CharacterBody2D
	monster.position = $GameMap.spawns[randi_range(0,2)].position
	add_child(monster)




func _on_spawn_timer_timeout():
	spanwRandom()
