extends BaseState
class_name PlayerAttaqueSpeciale

@export var player : Player
var anim_player : AnimationPlayer
var last_direction : Vector2 = Vector2.DOWN
@export var push_force : float = 700.0
@export var deceleration : float = 800.0
var current_push : float = 0.0
@export var attack_damage : int = 30
@export var knockback_force : float = 500.0
var damage_area_colider : CollisionShape2D
var damage_area : Area2D
var damage_area_coliding : bool = false
var sound_player : AudioStreamPlayer
@onready var special_timer : Timer = $"../../RegenSpecialTimer"

func manage_input() -> void:
	#if Input.is_action_just_pressed("Bouton A"):
		#other_attack = true
	pass

func enter(direction = Vector2.DOWN) -> void:
	last_direction = direction
	anim_player = player.get_animation_player()
	sound_player = $"../../AttackSepcSoundEffect"
	current_push = push_force
	player.velocity = last_direction * current_push
	var random_pitch_value = randf_range(0.75, 1.25)
	
	sound_player.pitch_scale = random_pitch_value
	sound_player.play()
	
	damage_area = $"../../Area2DAttaqueSpeciale"
	damage_area_colider = $"../../Area2DAttaqueSpeciale/CollisionShape2D"
	damage_area_colider.disabled = false
	player.is_special_regen = false
	special_timer.stop()
	
func update(delta: float) -> void:
	if not anim_player :
		anim_player = player.get_animation_player()
	manage_input()
	
func physics_update(delta: float) -> void:
	if not anim_player : return
	
	anim_player.play("Attaque_speciale")
	
	if current_push > 0:
		current_push = max(current_push - deceleration * delta, 0)
		player.velocity = last_direction * current_push
	else:
		player.velocity = Vector2.ZERO


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "Attaque_speciale":
		damage_area_colider.disabled  = true
		damage_area_coliding = false
		special_timer.start()
		Transitioned.emit(self, "Idle", last_direction)
		

func apply_knockback_to_target(target: Node2D, target_position: Vector2):
	# Applique un recul à l'ennemi en fonction de la direction de l'attaque
	var knockback_vector = (target_position - player.global_position).normalized() * knockback_force
	if target.has_method("apply_knockback"):
		target.apply_knockback(knockback_vector)

func target_attacked(body: Node2D) -> void:
	if body.has_method("take_damage"):
		body.take_damage(attack_damage)
		apply_knockback_to_target(body, body.global_position)

func _on_area_2d_attaque_speciale_body_entered(body: Node2D) -> void:
	target_attacked(body)
