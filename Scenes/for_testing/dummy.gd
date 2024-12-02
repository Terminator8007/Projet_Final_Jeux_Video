extends CharacterBody2D
class_name Ennemis

var health : int = 100
@export var friction : float = 600.0  # Taux de ralentissement
@export var invincibility_duration : float = 0.4  # Durée d'invincibilité en secondes
var is_invincible : bool = false  # État d'invincibilité
var damage : int = 3
@export var patrol_speed: float = 100.0
@export var chase_speed: float = 150.0
var is_chasing: bool = false
var player_detected: bool = false
var target_point: Vector2 = Vector2.ZERO
var patrol_wait_timer: Timer
@export var patrol_wait_time: float = 2.0
@export var patrol_area: Area2D
var patrol_point_arrived: bool = false
var look_at_point_stop: Vector2 = Vector2(0, 0)

func _ready():
	add_to_group("enemies")
	damage = randi_range(3, 8)
	patrol_wait_timer = $PatrolWaitTimer
	
	_generate_new_patrol_point()

func _physics_process(delta: float) -> void:
	if is_invincible:
		move_and_slide()
		return
	
	if is_chasing and player_detected:
		chase_player(delta)
	else:
		patrol(delta)
	
	# Oriente le sprite et le champ de vision dans la direction du mouvement
	if velocity.length() > 0 && !patrol_point_arrived:
		look_at(position + velocity.normalized() * 10)
		look_at_point_stop = position + velocity.normalized() * 10
		velocity = velocity.move_toward(Vector2.ZERO, friction * delta)
	
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

func patrol(delta: float):
	if patrol_area == null:
		return
	
	if target_point.distance_to(position) < 25.0 and !patrol_point_arrived:
		velocity = Vector2.ZERO
		patrol_point_arrived = true
		patrol_wait_timer.wait_time = randf_range(1, 3)
		patrol_wait_timer.start()
		look_at(look_at_point_stop)
		return
	if !patrol_point_arrived:
		var direction = (target_point - position).normalized()
		velocity = direction * patrol_speed

func chase_player(delta: float):
	var player = get_node("../Main_Character") as CharacterBody2D
	var direction = (player.position - position).normalized()
	look_at(player.position)
	look_at_point_stop = player.position
	velocity = direction * chase_speed

func _on_vision_area_2d_body_entered(body: Node2D) -> void:
	if body.has_method("player"):
		player_detected = true
		is_chasing = true


func _on_vision_area_2d_body_exited(body: Node2D) -> void:
	if body.has_method("player"):
		player_detected = false
		is_chasing = false

func _generate_new_patrol_point():
	patrol_point_arrived = false
	if patrol_area == null:
		return
	
	# Obtenir les limites de l'Area2D
	var patrol_shape = patrol_area.get_node("CollisionShape2D") as CollisionShape2D
	if patrol_shape.shape is RectangleShape2D:
		var bounds = patrol_shape.shape.extents
		
		var patrol_origin = patrol_area.global_position
		target_point = patrol_origin + Vector2(
			randf_range(-bounds.x, bounds.x),
			randf_range(-bounds.y, bounds.y)
		)
		
