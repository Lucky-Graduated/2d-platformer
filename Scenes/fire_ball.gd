extends Area2D

var travelled_distance = 0

func _physics_process(_delta: float) -> void:
	const SPEED = 1000
	const RANGE = 1200

	var direction = Vector2.RIGHT.rotated(rotation)
	position += direction * SPEED * _delta

	travelled_distance += SPEED * _delta
	if travelled_distance > RANGE:
		queue_free()


func _on_body_entered(_body: Node2D) -> void:
	if _body.is_in_group("player"):
		if _body.has_method("die"):
			_body.die()

	call_deferred("queue_free")
