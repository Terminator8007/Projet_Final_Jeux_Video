class_name OptionsTabContainer
extends Control

@onready var tab_container = $TabContainer as TabContainer

signal Exit_Options_menu

func _process(delta):
	options_menu_input()
	
func change_tab(tab : int) -> void:
	tab_container.set_current_tab(tab)

func options_menu_input() -> void:
	if Input.is_action_just_pressed("Droite"):
		if tab_container.current_tab >= tab_container.get_tab_count() - 1:
			change_tab(0)
			return
		var next_tab = tab_container.current_tab + 1
		change_tab(next_tab)
	if Input.is_action_just_pressed("Gauche"):
		if tab_container.current_tab == 0:
			change_tab(tab_container.get_tab_count() - 1)
		
		var previous_tab = tab_container.current_tab - 1
		change_tab(previous_tab)
		
	if Input.is_action_just_pressed("Bouton B") or Input.is_action_just_pressed("Start"):
		Exit_Options_menu.emit()
