extends KinematicBody2D

#const MOVEMENT_SPEED = 100
#const GRAVITY = 25
#const JUMP_POWER = -450
#const FLOOR = Vector2(0, -1)
#
#var velocity = Vector2()
#var on_ground = false
var is_attacking = false
var is_dead = false
#
#
#func _physics_process(delta):
#	#Basic movement mechanics/animations being played
#	if is_dead == false:
#		if Input.is_action_pressed("ui_left"):
#			velocity.x = -MOVEMENT_SPEED
#			$AnimatedSprite.flip_h = true
#			if is_attacking == false:
#				$AnimatedSprite.play("run")
#		elif Input.is_action_pressed("ui_right"):
#			velocity.x = MOVEMENT_SPEED
#			$AnimatedSprite.flip_h = false
#			if is_attacking == false:
#				$AnimatedSprite.play("run")
#		else:
#			velocity.x = 0
#			if on_ground == true && is_attacking == false:
#				$AnimatedSprite.play("idle")
#
#		if Input.is_action_pressed("ui_up"):
#			if on_ground == true:
#				velocity.y = JUMP_POWER
#				on_ground = false
#
#
#		velocity.y += GRAVITY
#
#		if Input.is_action_just_pressed("ui_focus_next") && is_attacking == false:
#			#attack
#			is_attacking = true
#			$AnimatedSprite.play("attack")
#
#
#
#		if is_on_floor():
#			on_ground = true
#		else:
#			on_ground = false
#			if is_attacking == false:
#				if velocity.y < 0:
#					$AnimatedSprite.play("jump")
#				else:
#					$AnimatedSprite.play("fall")
#
#
#		velocity = move_and_slide(velocity, FLOOR)
#
#		if get_slide_count() > 0:
#			for i in range(get_slide_count()):
#				if "Enemy" in get_slide_collision(i).collider.name:
#					dead()

var velocity := Vector2.ZERO

export var jump_height : float
export var jump_time_to_peak : float
export var jump_time_to_descent : float
export var max_speed : float
export var acceleration : float
export var friction_percent: float


onready var jump_velocity : float = ((2.0 * jump_height) / (jump_time_to_peak)) * -1.0
onready var jump_gravity : float = ((-2.0 * jump_height) / (jump_time_to_peak * jump_time_to_peak)) * -1.0
onready var fall_gravity : float = ((-2.0 * jump_height) / (jump_time_to_descent * jump_time_to_descent)) * -1.0

const GRAVITY = 10
const JUMP_POWER = -250
const FLOOR = Vector2(0 , -1)


var friction = false 
var on_ground = false

func _physics_process(delta):
	velocity.y += get_gravity() * delta

	if Input.is_action_pressed("ui_right"):
		velocity.x = min(velocity.x + acceleration, max_speed)
		$AnimatedSprite.flip_h = false
		$AnimatedSprite.play("run")
	elif Input.is_action_pressed("ui_left"):
		velocity.x = max(velocity.x - acceleration, -max_speed)
		$AnimatedSprite.flip_h = true
		$AnimatedSprite.play("run")
	else:
		velocity.x = lerp(velocity.x, 0, friction_percent)
		if on_ground == true:
			$AnimatedSprite.play("idle")

	if Input.is_action_pressed("ui_up") && on_ground:
		velocity.y = jump_velocity
		on_ground = false

	velocity.y += GRAVITY

	if is_on_floor():
		on_ground = true
	else:
		on_ground = false
		if velocity.y < 0:
			$AnimatedSprite.play("jump")
		else:
			$AnimatedSprite.play("fall")

	velocity = move_and_slide(velocity, FLOOR)
	
func get_gravity() -> float:
	return jump_gravity if velocity.y < 0.0 else fall_gravity

func dead():
	is_dead = true
	velocity = Vector2(0, 0)
	$AnimatedSprite.play("idle")
	$CollisionShape2D.disabled = true
	$Timer.start()

func _on_AnimatedSprite_animation_finished():
	is_attacking = false


func _on_Sword_Hitbox_body_entered(body):
	if "Enemy" in body.name && is_attacking == true:
		body.dead()

func _input(event):
	if event.is_action_pressed("ui_interact"):
		if $PickupZone.items_in_range.size() > 0:
			var pickup_item = $PickupZone.items_in_range.values()[0]
			pickup_item.pick_up_item(self)
			$PickupZone.items_in_range.erase(pickup_item)


func _on_Timer_timeout():
	get_tree().change_scene("res://Title_Screen.tscn")
