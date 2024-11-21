extends Control

@onready var health_timer : Timer = $background/healthbar_Pannel/health_timer
@onready var special_timer : Timer = $background/specialbar_Pannel/special_timer
@onready var health_bar : TextureProgressBar = $background/healthbar_Pannel/healthbar
@onready var special_bar : TextureProgressBar = $background/specialbar_Pannel/specialbar
@onready var health_bar_white : TextureProgressBar = $background/healthbar_Pannel/healthbar_white
@onready var special_bar_white : TextureProgressBar = $background/specialbar_Pannel/specialbar_white
@export var player : Player

var health = 0 : set = _set_health
var special = 0 : set = _set_special

func _set_health(new_health):
	health = min(health_bar.max_value, new_health)
	health_bar.value = health
	health_timer.start()

func init_health(_health) -> void:
	health = _health
	health_bar.max_value = health
	health_bar.value = health
	health_bar_white.max_value = player.max_health
	health_bar_white.value = player.health

func _set_special(new_special):
	
	special = min(special_bar.max_value, new_special)
	special_bar.value = special
	special_timer.start()

func init_special(_special) -> void:
	special = _special
	special_bar.max_value = special
	special_bar.value = special
	special_bar_white.max_value = player.max_special
	special_bar_white.value = player.special

func _on_health_timer_timeout() -> void:
	health_bar_white.value = health


func _on_special_timer_timeout() -> void:
	special_bar_white.value = special
