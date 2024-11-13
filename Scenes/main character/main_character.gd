extends GenericCharacter
class_name Player

func _ready() -> void:
	anim_player = $AnimationPlayer
	sprite = $Sprite2D
	sprite_attaque = $Sprite2D2
	anim_player.play("Idle_Bas")


func _physics_process(delta: float) -> void:
	move_and_slide()
