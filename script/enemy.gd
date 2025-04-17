extends CharacterBody3D

@onready var NAV_AGENT = $NavigationAgent3D
@onready var DAMAGE_LABEL = $"../../UI/Damage_Counter"

var RAND_POSITIOM = RandomNumberGenerator.new()

var SPEED = 4.0

var HEALTH = 100

var NEXT_POSITION
var CURRENT_POSITION
var MAIN_POSITION

func _ready():
	MAIN_POSITION = global_transform.origin

func _physics_process(delta):
	if HEALTH <= 0:
		queue_free()
	
	NEXT_POSITION = NAV_AGENT.get_next_path_position()
	CURRENT_POSITION = global_transform.origin
	
	if NAV_AGENT.distance_to_target() < 10:
		velocity = velocity.move_toward((NEXT_POSITION - CURRENT_POSITION).normalized() * SPEED, .25)
		move_and_slide()
	
	else:
		NAV_AGENT.target_position = MAIN_POSITION
		velocity = velocity.move_toward((NEXT_POSITION - CURRENT_POSITION).normalized() * SPEED, .25)
		move_and_slide()
	
func update_target_position(target_position):
	NAV_AGENT.target_position = target_position


func take_damage(amount: int):
	var ANIME_DAMAGE = DAMAGE_LABEL.get_node("AnimationPlayer")
	ANIME_DAMAGE.play('fade_up')
	
	HEALTH -= amount
	RAND_POSITIOM.randomize()
	DAMAGE_LABEL.position.x = RAND_POSITIOM.randi_range(736, 660)
	DAMAGE_LABEL.position.y = RAND_POSITIOM.randi_range(360, 312)
	DAMAGE_LABEL.text = str(amount)
	var TIMER = DAMAGE_LABEL.get_node("Timer")
	TIMER.start()
