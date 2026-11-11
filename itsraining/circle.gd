extends CharacterBody2D

signal hit_someone
# can send

@export var speed = 500

var max_velocity = 800

func start():
	position = get_viewport_rect().size / 2
	var direction_x = 1.0 if randf() > 0.5 else -1.0
	# yay gambling
	
	var direction_y = randf_range(0.5,1)
	# yay more gambling
	
	velocity = Vector2(direction_x,direction_y).normalized() * speed
	# normalized makes the vector an integer (pythagorean theorem it)
func _ready():
	start()
	# that way start() can be called to reset ball during game too

func _physics_process(delta):
	#if position.y < 0:
		#if(randf() < 0.5):
			#var copy := duplicate()
			#get_parent().add_child(copy)
			#
			#var randscale = randf()
			#copy.scale = Vector2(1+randscale,1+randscale)

	var collision = move_and_collide(velocity * delta)
	# move and collide returns a boolean if it hits something
	if collision:
		velocity = velocity.bounce(collision.get_normal())
		# bounce reflects the thing for us
		var thing_we_hit = collision.get_collider()
		print(thing_we_hit)
		if !thing_we_hit.is_in_group("players"):
			if(abs(velocity.x) < max_velocity && abs(velocity.y) < max_velocity):
				print(velocity)
				velocity *= 1.1 # 10% inc
		else:
			hit_someone.emit()
