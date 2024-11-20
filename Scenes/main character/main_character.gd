extends GenericCharacter
class_name Player

@export var health : int = 256
@export var special : int = 128
@export var max_health : int = 256
@export var max_special : int = 128
@onready var bar : Control = $Control 

func _ready() -> void:
	anim_player = $AnimationPlayer
	sprite = $Sprite2D
	sprite_attaque = $Sprite2D2
	bar.init_health(health)
	bar.init_special(special)
	anim_player.play("Idle_Bas")


func _physics_process(delta: float) -> void:
	move_and_slide()

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.has_method("ennemy"):
		if !body.is_invincible:
			health -= body.damage
			bar.health = health
