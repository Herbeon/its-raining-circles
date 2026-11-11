extends CharacterBody2D



@export var speed = 500
@export var jump_velocity = -700
@export var up_action = "p1_up"
@export var pow_action = "p1_pow"
@export var left_action = "p1_left"
@export var right_action = "p1_right"
@export var power = "doryfish"

@onready var animated_sprite = $AnimatedSprite2D

func _ready():
	animated_sprite.play("default")
	add_to_group("players")

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed(up_action) and is_on_floor():
		velocity.y = jump_velocity

	if Input.is_action_just_pressed(pow_action):
		use_pow(power)
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis(left_action, right_action)
	if direction:
		velocity.x = direction * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)

	move_and_slide()
	
func use_pow(powperson):
	if(powperson == "doryfish"):
		print("doryfish power")
