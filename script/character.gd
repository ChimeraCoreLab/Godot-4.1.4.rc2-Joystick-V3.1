extends CharacterBody3D

@onready var HEAD = $Head
@onready var HAND = $Head/Eye/Camera3D/Hand


@onready var JOY_BTN = $"../UI/JoyButton"
@onready var JUMP_BTN = $"../UI/JumpBtn"
@onready var RUN_BTN = $"../UI/RunBtn"

@onready var BULLET = preload("res://scene/bullet.tscn")

const SENSITIVITY = 0.3
var RUN_BTN_MODE = false
var SPEED = 4.0
const JUMP_VELOCITY = 4.5

const lerp_time = 10
var direction = Vector3.ZERO


var is_running = false


var gravity = 9.8

func _input(event):
	if event is InputEventScreenDrag:
		if event.position.x > 400:
			rotate_y(deg_to_rad(-event.relative.x * SENSITIVITY))
			HEAD.rotate_x(deg_to_rad(-event.relative.y * SENSITIVITY))
		
			HEAD.rotation.x = clamp(HEAD.rotation.x, deg_to_rad(-80), deg_to_rad(60))
			
			HAND.position.x -= event.relative.x * 0.0002
			HAND.position.y += event.relative.y * 0.0002
			

func _physics_process(delta):
	
	
	if JOY_BTN.is_pressed or JOY_BTN.joy_is_pressed():
		
		var GUN_RAY_POS = Gun_RayCast(2000)
		
		rotate_y(deg_to_rad(-JOY_BTN.output.x * 0.2))
		HEAD.rotate_x(deg_to_rad(-JOY_BTN.output.y * 0.2))
		
		HEAD.rotation.x = clamp(HEAD.rotation.x, deg_to_rad(-80), deg_to_rad(60))
		
		if !HAND.get_child(0).ANINE.is_playing():
			HAND.get_child(0).ANINE.play('shoot')
			
			var MUJJEL = HAND.get_child(0).MUJJEL
			var B_INST = BULLET.instantiate()
			
			MUJJEL.add_child(B_INST)
			B_INST.look_at(GUN_RAY_POS, Vector3.UP)

	
	if not is_on_floor():
		velocity.y -= gravity * delta

	#JUMP
	if Input.is_action_just_pressed("ui_accept") or JUMP_BTN.is_pressed() and is_on_floor():
		velocity.y = JUMP_VELOCITY
		

	var input_dir = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	
	if RUN_BTN.is_pressed():
		input_dir.y = -1
		SPEED = 8.0
		is_running = true
		
	else:
		SPEED = 4.0
		is_running = false
		
		
	direction = lerp(direction, (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized(), delta * lerp_time)
	
	if direction:
		
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)
		
	HAND.position.x = lerp(HAND.position.x, 0.0, delta * 5)
	HAND.position.y = lerp(HAND.position.y, 0.0, delta * 5)

	move_and_slide()


func Gun_RayCast(RANGE : int):
	var CAMERA = get_viewport().get_camera_3d()
	var VIEWPORT_CENTER = (get_viewport().size/2)
	
	var RAY_ORIGIN = CAMERA.project_ray_origin(VIEWPORT_CENTER)
	var RAY_END = RAY_ORIGIN + CAMERA.project_ray_normal(VIEWPORT_CENTER) * RANGE
	
	var New_Intersection = PhysicsRayQueryParameters3D.create(RAY_ORIGIN, RAY_END)
	var INTERSECTION = get_world_3d().direct_space_state.intersect_ray(New_Intersection)
	
	if !INTERSECTION.is_empty():
		return INTERSECTION.position
	else:
		return RAY_END
	
	
