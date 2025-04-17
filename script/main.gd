extends Node3D

@onready var PLAYER = $Character

func _process(delta):
	get_tree().call_group("enemy", "update_target_position", PLAYER.global_transform.origin)
	

func _on_timer_timeout():
	$UI/Damage_Counter.text = ""
