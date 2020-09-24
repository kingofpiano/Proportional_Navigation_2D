extends KinematicBody2D


var velocity = Vector2(1, 0)
var speed = 1


func _ready() -> void:
	randomize()
	var Back = $"/root/Main/TextureRect"
	position.x = randi() % int(Back.get_size().x)
	position.y = randi() % int(Back.get_size().y)


func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("SPACE"):
		$Ray.visible = not $Ray.visible
	global_position += velocity
	$Ray.rotation = velocity.angle() + PI / 2


func _on_Timer_timeout() -> void:
	velocity.x = randi() % 3 - 1
	velocity.y = randi() % 3 - 1
	while velocity == Vector2.ZERO:
		velocity.x = randi() % 3 - 1
		velocity.y = randi() % 3 - 1
	$Timer.wait_time = randi() % 5 + 2
