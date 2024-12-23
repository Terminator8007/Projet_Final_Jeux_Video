extends GenericCharacter
class_name Player

@export var health : int = 256
@export var special : int = 128
@export var max_health : int = 256
@export var max_special : int = 128
@onready var bar : Control = $Control 
var is_special_regen : bool = false
@onready var active_special_timer : Timer = $SpecialRegenActiveTimer
@onready var regen_special_timer : Timer = $RegenSpecialTimer
@onready var scene_fin : PackedScene = preload("res://Scenes/fin/scene_fin.tscn")

func _ready() -> void:
	anim_player = $AnimationPlayer
	sprite = $Sprite2D
	sprite_attaque = $Sprite2D2
	bar.init_health(health)
	bar.init_special(special)
	anim_player.play("Idle_Bas")

func _physics_process(delta: float) -> void:
	move_and_slide()
	if (health < 0):
		health = 0
		bar.special_bar_white.value = health
		Global.player_alive = false
		die()

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.has_method("ennemy"):
		if !body.is_invincible:
			health -= body.damage
			bar.health = health


func _on_regen_special_timer_timeout() -> void:
	is_special_regen = true
	active_special_timer.start()


func _on_special_regen_active_timer_timeout() -> void:
	if is_special_regen:
		active_special_timer.start()
		if special < max_special:
			special += 3
			bar.special = special
			bar.special_bar_white.value = special
		else:
			special = max_special
			bar.special_bar_white.value = special
func player():
	pass

func die():
	get_tree().change_scene_to_packed(Global.end_scene)
