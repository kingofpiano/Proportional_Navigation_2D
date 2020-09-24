extends KinematicBody2D


onready var plane = $"/root/Main/Plane"
onready var rocket_velocity = Vector2(2, 0)

var target = Vector2.ZERO


func _ready() -> void:
	randomize()
	var Back = $"/root/Main/TextureRect"
	position.x = randi() % int(Back.get_size().x)
	position.y = randi() % int(Back.get_size().y)


func guidance():
	var k = 1
	while abs(int(round((plane.global_position + k * plane.velocity - global_position).length())) - abs(k * rocket_velocity.x)) > rocket_velocity.x:
		k += 1 
	rotation = (plane.global_position + k * plane.velocity - global_position).angle()


func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("SPACE"):
		$Ray.visible = not $Ray.visible
	if target != plane.velocity:
		guidance()
	var collision_info = move_and_collide(rocket_velocity.rotated(rotation))
	if collision_info:
		get_tree().reload_current_scene()
	target = plane.velocity
