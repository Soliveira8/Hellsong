extends CharacterBody2D

const aceleration = 100
const SPEED = 92
const JUMP_VELOCITY = -200
const GRAVITY = 500 
const friction = 5
var direction: int




func _physics_process(delta: float) -> void:
	var direction = Input.get_axis("ui_left", "ui_right")
	apply_gravity(delta)
	handle_jump(delta)
	move_and_slide()
	agachando(delta,friction,direction)
	aceleratron(delta,direction)
	muda_direçao_mais_freiamento(velocity,direction)
	fricton(delta,direction)
	print(direction)


func apply_gravity(delta: float): 
	if not is_on_floor():
		velocity.y += GRAVITY * delta
func handle_jump(delta): 
	print($AnimatedSprite2D.frame)
	
	
	
	if velocity.y > 0:
		$AnimatedSprite2D.frame = 36
		
		
		
		
	 
	
	if is_on_floor():
		if Input.is_action_just_pressed("ui_accept"):
			velocity.y = JUMP_VELOCITY
			$AnimatedSprite2D.play("Ivan_jump") 
			$AnimatedSprite2D.frame = 19
	else:
		if Input.is_action_just_released("ui_accept") and velocity.y < JUMP_VELOCITY / 2:
			velocity.y = JUMP_VELOCITY / 4
			$AnimatedSprite2D.play("Ivan_jump")
			$AnimatedSprite2D.frame = 19
			
			
			
func muda_direçao_mais_freiamento(velocity,direction):
	if sign(velocity.x) != sign(direction) and is_on_floor():
		velocity.x = lerp(velocity.x,sign(direction),0.1)
		$AnimatedSprite2D.play("Ivan_agachado")
func aceleratron(delta,direction):
	if  direction != 0 and not Input.is_action_pressed("ui_down") and is_on_floor():
		velocity.x = move_toward(velocity.x, SPEED * direction, aceleration * delta)
		$AnimatedSprite2D.speed_scale = lerp($AnimatedSprite2D.speed_scale, 8.0, aceleration / 100 * delta)
		$AnimatedSprite2D.play("Ivan_running")
		$AnimatedSprite2D.flip_h = direction < 0
func fricton(delta,direction): 
	if direction == 0 and is_on_floor() and not Input.is_action_pressed("ui_down"):
		velocity.x = lerp(velocity.x,0.0,0.1)
		$AnimatedSprite2D.play("Ivan_idle")
		$AnimatedSprite2D.frame = 0
func agachando(delta,friction,direction):
	
	if Input.is_action_pressed("ui_down") and is_on_floor():
		$AnimatedSprite2D.play("Ivan_agachado")
		velocity.x = lerp(velocity.x, 0.0, friction * delta)
