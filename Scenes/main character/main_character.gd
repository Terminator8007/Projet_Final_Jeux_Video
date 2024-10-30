extends GenericCharacter
class_name Player

func _ready() -> void:
	anim_player = $AnimationPlayer
	sprite = $Sprite2D
	anim_player.play("Idle_Bas")


func _physics_process(delta: float) -> void:
	move_and_slide()
