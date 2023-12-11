extends Node
signal  attack(damage)
signal wizardAttack(pos,dir)
var player_pos : Vector2
var monstersCount : int = 0
var playerHealth : int = 100
signal playerDeath
signal respawn
var score : int
