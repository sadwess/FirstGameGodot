extends CharacterBody2D

@onready var max_speed = 500
@onready var dirs = { "right": Vector2(1,0),"left": Vector2(-1, 0) }
@onready var current_dir = dirs.right
@onready var attack : bool = false
signal shoot(pos,dir)



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if Input.is_action_just_pressed("attack"):	
		$Animations.play("attack")
		$Timer.start()
		attack = true
		
		
	var direction = Input.get_vector("gauche","droite","haut","bas")
	velocity = direction * max_speed
	move_and_slide()
	if attack==false:
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
	if v == Vector2.ZERO:
		$Animations.play("idle")
	else:
		$Animations.play("run")
func shooting():
		var dir = (get_global_mouse_position() - position).normalized()
		shoot.emit($Marker2D.global_position,dir)

func _on_timer_timeout():
	attack = false
