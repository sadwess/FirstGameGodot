extends CharacterBody2D
@onready var dirs = { "right": Vector2(1,0),"left": Vector2(-1, 0) }
@onready var current_dir = dirs.right
var last_state = false
var death : bool = false
var spawned : bool = false
var active_attack : bool = false
var health : int = 100
var walk : bool = true
var canFire : bool = true
func _ready():
	$run.visible = false
	$attack.visible = false
	$die.visible = true
	$AnimationPlayer.play("spawn",-1,1,true)
	$SpawnTimer.start()
func _process(_delta):
	if !death and spawned:
		$die.visible = false
		if !active_attack:
			if walk:
				$attack.visible = false
				$run.visible = true
				velocity = (Service.player_pos - position).normalized() * 100
				move_and_slide()
				flip()
				if !last_state:
					$AnimationPlayer.play("run")
					last_state =true
		else :
			$run.visible = false
			$attack.visible = true
			flip()
			if canFire:
				
				
				$AnimationPlayer.play("attack")
				canFire = false
				$FireTimer.start()

func _on_range_body_entered(body):
	active_attack = true


func _on_range_body_exited(body):
	active_attack = false

func shooting():
			var dir = (Service.player_pos - position).normalized()
			Service.emit_signal("wizardAttack",$Marker2D.global_position,dir)
func flip():
	if Service.player_pos.x > global_position.x:
		if current_dir == dirs.left:
			current_dir = dirs.right
			scale.x *= -1
	elif Service.player_pos.x < global_position.x:
			if current_dir == dirs.right:
				current_dir = dirs.left
				scale.x *= -1
func hit():
	health-=25
	if(health!=0):
		var tween = get_tree().create_tween()
		tween.tween_property(self,"modulate",Color.WHITE,1)
		walk = false
		$HitTimer.start()
	else:
		$run.visible = false
		$attack.visible = false
		$die.visible = true
		death = true
		$AnimationPlayer.play("death")


func _on_hit_timer_timeout():
	walk =	true


func _on_fire_timer_timeout():
	canFire = true


func _on_spawn_timer_timeout():
	spawned = true
