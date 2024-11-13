extends CharacterBody2D

var health : int = 100

func _physics_process(delta: float) -> void:
	move_and_slide()

func take_damage(damage : int) -> void:
	health -= damage
	print(health)
	if health <= 0:
		die()

func apply_knockback(knockback_vector : Vector2) -> void:
	print(knockback_vector)
	velocity = knockback_vector

func die():
	queue_free()
