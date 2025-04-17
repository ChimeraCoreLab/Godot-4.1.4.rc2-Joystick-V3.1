extends RayCast3D

signal Body_Enterd(body)

func _process(delta):
	if is_colliding():
		print('yyy')
		Body_Enterd.emit(get_collider())
