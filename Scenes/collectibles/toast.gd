extends Sprite2D
@onready var audio: AudioStreamPlayer = $AudioStreamPlayer

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.has_method("player"):
		visible = false
		Global.toast_cellecter += 1
		audio.play()


func _on_audio_stream_player_finished() -> void:
	queue_free()
