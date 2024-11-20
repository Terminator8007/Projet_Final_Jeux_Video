extends CharacterBody2D

var health : int = 100
@export var friction : float = 600.0  # Taux de ralentissement
@export var invincibility_duration : float = 0.4  # Durée d'invincibilité en secondes
var is_invincible : bool = false  # État d'invincibilité
var damage : int = 3

func _physics_process(delta: float) -> void:
	# Applique la friction si le personnage est en mouvement
	if velocity.length() > 0:
		velocity = velocity.move_toward(Vector2.ZERO, friction * delta)
	
	# Applique le mouvement
	move_and_slide()

func take_damage(damage_taken : int) -> void:
	if is_invincible:
		return
	
	health -= damage_taken
	if health <= 0:
		die()
	else:
		is_invincible = true
		$InvincibilityTimer.start()

func apply_knockback(knockback_vector : Vector2) -> void:
	velocity = knockback_vector

func die():
	queue_free()

func _on_timer_timeout() -> void:
	is_invincible = false

func ennemy():
	pass
