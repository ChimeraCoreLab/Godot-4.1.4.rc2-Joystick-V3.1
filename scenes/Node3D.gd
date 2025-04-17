extends Node3D

@onready var footstep_sound1 : AudioStreamPlayer3D = get_node(NodePath("Player/Node3D/footstep2"))
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
func _play_footstep():
	footstep_sound1.pitch_scale = randf_range(.1, 1)
	footstep_sound1.play()

# Called every frame. 'delta' is the elapsed time since the previ
