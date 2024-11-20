extends BaseState
class_name PlayerAttaque3

@export var player : Player
var anim_player : AnimationPlayer
var last_direction : Vector2 = Vector2.DOWN
var push_force : float = 450.0
var deceleration : float = 1200.0
var current_push : float = 0.0
var attack_damage : int
var knockback_force : float = 400.0
var damage_area_colider : CollisionShape2D
var damage_area : Area2D
var damage_area_coliding : bool = false
var sound_player : AudioStreamPlayer

func manage_input() -> void:
	#if Input.is_action_just_pressed("Bouton A"):
		#other_attack = true
	pass

func enter(direction = Vector2.DOWN) -> void:
	last_direction = direction
	anim_player = player.get_animation_player()
	sound_player = $"../../AttackSoundEffect"
	current_push = push_force
	player.velocity = last_direction * current_push
	var random_pitch_value = randf_range(0.75, 1.25)
	
	sound_player.pitch_scale = random_pitch_value
	sound_player.play()
	
	if last_direction.x > 0.7:
		damage_area = $"../../Area2DDroite"
		damage_area_colider = $"../../Area2DDroite/CollisionShape2D"
	elif last_direction.x < -0.7:
		damage_area = $"../../Area2DGauche"
		damage_area_colider = $"../../Area2DGauche/CollisionShape2D"
	elif last_direction.y < -0.7:
		damage_area = $"../../Area2DHaut"
		damage_area_colider = $"../../Area2DHaut/CollisionShape2D"
	elif last_direction.y > 0.7:
		damage_area = $"../../Area2DBas"
		damage_area_colider = $"../../Area2DBas/CollisionShape2D"
	damage_area_colider.disabled = false
	
func update(delta: float) -> void:
	if not anim_player :
		anim_player = player.get_animation_player()
	manage_input()
	
func physics_update(delta: float) -> void:
	if not anim_player : return
	
	if last_direction.x > 0.7:
		anim_player.play("Attaque3_coter")
		player.sprite_attaque.flip_h = false
	elif last_direction.x < -0.7:
		anim_player.play("Attaque3_coter")
		player.sprite_attaque.flip_h = true
	elif last_direction.y < -0.7:
		anim_player.play("Attaque3_haut")
	elif last_direction.y > 0.7:
		anim_player.play("Attaque3_bas")
		
	if current_push > 0:
		current_push = max(current_push - deceleration * delta, 0)
		player.velocity = last_direction * current_push
	else:
		player.velocity = Vector2.ZERO


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "Attaque3_coter" or anim_name == "Attaque3_haut" or anim_name == "Attaque3_bas":
		damage_area_colider.disabled  = true
		damage_area_coliding = false
		Transitioned.emit(self, "Idle", last_direction)
		

func apply_knockback_to_target(target, direction):
	if target.has_method("apply_knockback"):
		target.apply_knockback(direction * knockback_force)

func target_attacked(body: Node2D) -> void:
	if body.has_method("take_damage"):
		if body.is_invincible == false:
			attack_damage = 20
			body.take_damage(attack_damage)
			apply_knockback_to_target(body, last_direction)

func _on_area_2d_haut_body_entered(body: Node2D) -> void:
	target_attacked(body)


func _on_area_2d_bas_body_entered(body: Node2D) -> void:
	target_attacked(body)


func _on_area_2d_droite_body_entered(body: Node2D) -> void:
	target_attacked(body)


func _on_area_2d_gauche_body_entered(body: Node2D) -> void:
	target_attacked(body)
