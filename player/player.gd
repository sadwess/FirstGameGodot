extends CharacterBody2D

@onready var max_speed = 500
@onready var dirs = { "right": Vector2(1,0),"left": Vector2(-1, 0) }
@onready var current_dir = dirs.right
signal shoot(pos,dir)
@onready var health : int = 100
@onready var attack : bool = false
@onready var damaged : bool = false
var death : bool = false

func _ready():
	Service.connect("attack",hit)


func _process(_delta):
	if !death:
		if Input.is_action_just_pressed("attack") and !attack:	
			$Animations.play("attack")
			$AttackTimer.start()
			attack = true
		var direction = Input.get_vector("gauche","droite","haut","bas")
		velocity = direction * max_speed
		move_and_slide()
		Service.player_pos = position
		if !attack:
			run_idle_anim(velocity)
		update_flip()

func update_flip():
	if get_global_mouse_position().x > global_position.x:
		if !Input.is_action_pressed("gauche"):
			if current_dir == dirs.left:
				current_dir = dirs.right
				scale.x = -1
		else:
			if current_dir == dirs.right:
				current_dir = dirs.left
				scale.x = -1
	elif get_global_mouse_position().x < global_position.x:
		if !Input.is_action_pressed("droite"):
			if current_dir == dirs.right:
				current_dir = dirs.left
				scale.x = -1
		else:
			if current_dir == dirs.left:
				current_dir = dirs.right
				scale.x = -1
func run_idle_anim(v):
	if !damaged:
		if v == Vector2.ZERO:
			$Animations.play("idle")
		else:
			$Animations.play("run")
func shooting():
		var dir = (get_global_mouse_position() - position).normalized()
		shoot.emit($Marker2D.global_position,dir)

func hit(damage):
	health-=damage
	if health>0:
		$Animations.play("damaged")
		damaged = true
		$DamagedTimer.start()
	elif health <= 0:
		$Animations.play("die")
		death = true

func _on_attack_timer_timeout():
	attack = false
func _on_damaged_timer_timeout():
	damaged = false
