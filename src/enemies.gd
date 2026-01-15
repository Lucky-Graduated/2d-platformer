extends CharacterBody2D

@export var SPEED = 100
@export var ATTACK_HURT = 10
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

var direction = 1
var enemy_death_count = 0

func _physics_process(_delta: float) -> void:
	velocity.x = SPEED * direction * _delta
	
	move_and_slide()
	
	if is_on_wall():
		direction *= -1
		animated_sprite_2d.flip_h = true

func _on_get_hurt_area_entered(_area: Area2D) -> void:
	queue_free()

func shoot():
	const FIREBALL = preload("res://Scenes/fire_ball.tscn")
	var fireball = FIREBALL.instantiate()

	get_parent().add_child(fireball)

	fireball.global_position = %ShootPivot.global_position
	fireball.global_rotation = %ShootPivot.global_rotation
