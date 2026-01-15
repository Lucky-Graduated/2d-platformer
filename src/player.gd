extends CharacterBody2D


@export var SPEED = 300.0
@export var  JUMP_VELOCITY = -400.0
@export var BULLET_SPEED = 1000


@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

var coin_collect = 0
@onready var scoreCount = %Score_Count


func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta

	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		animated_sprite_2d.play("jump")
		
	var direction := Input.get_axis("left", "right")
	if direction != 0:
		if direction > 0:
			%ShootPivot.rotation = 0
		else:
			%ShootPivot.rotation = PI

	
	if direction:
		velocity.x = direction * SPEED * delta
		animated_sprite_2d.play("run")
		if direction < 0:
			animated_sprite_2d.flip_h = true
		else:
			animated_sprite_2d.flip_h = false
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED * delta)
		animated_sprite_2d.play("idle")
	move_and_slide()
	
	
	if Input.is_action_just_pressed("shoot"):
		shoot()
		

func _on_coin_collector_area_entered(_area: Area2D) -> void:
	coin_collect += 1
	scoreCount.text = "x " + str(coin_collect)


func shoot():
	const _BULLET = preload("res://Scenes/shoot.tscn")
	var _new_bullet = _BULLET.instantiate()
	
	get_tree().current_scene.add_child(_new_bullet)
	
	_new_bullet.global_position = %ShootPivot.global_position
	_new_bullet.global_rotation = %ShootPivot.global_rotation
