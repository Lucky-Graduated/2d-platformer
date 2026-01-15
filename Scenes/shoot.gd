extends Area2D

var player = "res://Scenes/player.tscn"

var travelled_distance = 0
func _physics_process(_delta: float) -> void:
	const _SPEED = 1000
	const _RANGE = 1200
	
	var _direction = Vector2.RIGHT.rotated(rotation)
	position += _direction * _SPEED * _delta
	
	travelled_distance += _SPEED *_delta
	if travelled_distance > _RANGE:
		queue_free()


func _on_body_entered(_body: Node2D) -> void:
	queue_free()
