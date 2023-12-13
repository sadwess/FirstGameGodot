extends Node2D
var score = 0.0
var skeleton = preload("res://Enemies/skeleton.tscn")
var demon = preload("res://Enemies/demon.tscn")
var wizard = preload("res://Enemies/wizard.tscn")
var monsterTypeIncrement : int = 0
var paused : bool = false
@onready var monsters = [skeleton,demon,wizard]
func _ready():
	Input.set_custom_mouse_cursor(load("res://crosshair.png"))
	Service.connect("respawn",onPlayerRespawn)
	Service.connect("wizardAttack",on_wizard_shoot)
	Service.connect("playerDeath",onPlayerDeath)
	Service.connect("player_shoot",shoot)
func _process(delta):
	Service.monstersCount = $NavigationRegion2D/Monsters.get_children().size()
	scores(delta)

func on_wizard_shoot(pos,dir):
	var wP = preload("res://projectile/wizard_projectile.tscn").instantiate() as Area2D
	wP.position = pos
	wP.rotation_degrees = rad_to_deg(dir.angle()) 
	wP.direction = dir
	$".".add_child(wP)
func spanwRandom():
	var monster = monsters[randi_range(0,monsterTypeIncrement)].instantiate() as CharacterBody2D
	monster.position = $NavigationRegion2D/GameMap.spawns[randi_range(0,2)].position
	$NavigationRegion2D/Monsters.add_child(monster)

func onPlayerDeath():
	paused = true
	$UI.visible = false
	var question = preload("res://UI/question.tscn").instantiate() as CanvasLayer
	$DeathQuestionWindow.add_child(question)
func onPlayerRespawn():
	Input.set_custom_mouse_cursor(load("res://crosshair.png"))
	$UI.visible = true
	var player = preload("res://player/player.tscn").instantiate() as CharacterBody2D
	player.position = $GameMap.spawns[0].position
	$PlayerNode.add_child(player)
	paused = false
func scores(d):
	if !paused:
		score += d
	Service.score = score
	if score > 60 and monsterTypeIncrement == 0:
		monsterTypeIncrement+=1
	if score > 120 and  monsterTypeIncrement ==1:
		monsterTypeIncrement+=1	
func _on_spawn_timer_timeout():
	spanwRandom()
func shoot(pos,dir):
	print("s")
	var laser = preload("res://projectile/projectile.tscn").instantiate() as Area2D
	laser.position = pos
	laser.rotation_degrees = rad_to_deg(dir.angle()) 
	laser.direction = dir
	$".".add_child(laser)
