extends Node2D

func _on_hurtbox_area_entered(area: Area2D) -> void:
	if !area.owner.has_method("die"):
		return
	area.owner.die()
