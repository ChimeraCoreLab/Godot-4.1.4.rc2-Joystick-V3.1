extends Node3D

var footstep_sound1 = "res://player/footstep_sound/footstep1.wav"
var footstep_sound2 = "res://player/footstep_sound/footstep2.wav"
var footstep_sound3 ="res://player/footstep_sound/footstep3.wav"
var footstep_sound4 = "res://player/footstep_sound/footstep4.wav"
var footstep_sound5 = "res://player/footstep_sound/footstep5.wav"
var footstep_sound6 = "res://player/footstep_sound/footstep6.wav"
var footstep_sound7 = "res://player/footstep_sound/footstep7.wav"
var footstep_sound8 = "res://player/footstep_sound/footstep8.wav"
var footstep_sound9 = "res://player/footstep_sound/footstep9.wav"
var footstep_sound10 = "res://player/footstep_sound/footstep10.wav"

@onready var footstep_sounds = [footstep_sound1, footstep_sound2, footstep_sound3, footstep_sound4, footstep_sound5, footstep_sound6, footstep_sound7, footstep_sound8, footstep_sound9, footstep_sound10]

@onready var player = get_tree().get_root().find_node("Player", true ,false)

func _process(delta):
	if $Timer.is_stopped():
		if player.is_on_floor() and player.player_speed >= 2:
			var animation_speed = 1.0 / (player.player_speed / 2)
			if round(player.player_speed) > 3:
				play_sound(-20)
			elif round(player.player_speed) == 3:
				play_sound(-30)
			else:
				play_sound(-40)
			$Timer.wait_time = animation_speed
			$Timer.start()
	
	if player.is_on_floor() and player.snapped == false:
		play_sound(-10)

func play_sound(volume): # To avoid the sound from clipping, we generate a new audio node each time then we delete it
	var audio_node = AudioStreamPlayer.new()
	var pick_sound = randi() % footstep_sounds.size() # Pick a random sound
	audio_node.stream = footstep_sounds[pick_sound]
	audio_node.volume_db = volume
	audio_node.pitch_scale = randf_range(0.95, 1.05)
	add_child(audio_node)
	audio_node.play()
	#yield(get_tree().create_timer(2), "timeout")
	audio_node.queue_free()
