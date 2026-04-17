extends Node

enum GameState {
	GAMEPLAY,
	DEATH,
}
var game_state := GameState.GAMEPLAY

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("fullscreen"):
		var window_mode := DisplayServer.window_get_mode()
		var is_window: bool = window_mode != DisplayServer.WINDOW_MODE_FULLSCREEN
		DisplayServer.window_set_mode(
			DisplayServer.WINDOW_MODE_FULLSCREEN
			if is_window
			else DisplayServer.WINDOW_MODE_WINDOWED
		)
