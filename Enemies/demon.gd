extends CharacterBody2D
@onready var dirs = { "right": Vector2(1,0),"left": Vector2(-1, 0) }
@onready var current_dir = dirs.right
var active_attack : bool = false
var damage : int = 10
@onready var health : int = 100
var walk : bool = true
var death : bool = false
var spawned : bool = false
func _ready():
	$Animation.play("spawn",-1,1,true)
	$SpawnTimer.start()
func _process(_delta):
	if !death and spawned:
		if !active_attack:
			if walk:
				velocity = (Service.player_pos - position).normalized() * 100
				move_and_slide()
			
				if Service.player_pos.x > global_position.x:
					if current_dir == dirs.left:
						current_dir = dirs.right
						scale.x *= -1
				elif Service.player_pos.x < global_position.x:
					if current_dir == dirs.right:
						current_dir = dirs.left
						scale.x *= -1
				$Animation.play("walk")
		else:
			$Animation.play("attack")
			

func _on_range_body_entered(body):
	active_attack = true


func _on_range_body_exited(body):
	active_attack = false
	
func attacking():
	Service.emit_signal("attack",damage)
	
func hit():
	health-=25
	if(health!=0):
		$Animation.play("hit")
		walk = false
		$HitTimer.start()
	else:
		death = true
		$Animation.play("die")
	
func _on_hit_timer_timeout():
	walk = true


func _on_spawn_timer_timeout():
	spawned = true
