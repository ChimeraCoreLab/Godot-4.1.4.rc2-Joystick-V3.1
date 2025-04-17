extends RigidBody3D

var SPEED = 1

var DAMAGE_MIN = 10
var DAMAGE_MAX = 30

var RAND_DAMAGE = RandomNumberGenerator.new()

func _physics_process(delta):
	apply_impulse(-transform.basis.z * SPEED, -transform.basis.z)
	

func _on_timer_timeout():
	queue_free()


func _on_body_entered(body):
	if body.is_in_group('enemy'):
		if body.has_method('take_damage'):
			RAND_DAMAGE.randomize()
			body.take_damage(RAND_DAMAGE.randi_range(DAMAGE_MIN, DAMAGE_MAX))
	queue_free()
