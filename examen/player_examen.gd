extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0


func _physics_process(delta: float) -> void:
	
	
	
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()


func morir():


	# Detener inmediatamente cualquier movimiento
	velocity = Vector2.ZERO

	# Reiniciar escena. Esto vuelve a cargar la escena actual.
	get_tree().reload_current_scene()

func _on_area_2d_body_entered(body: Node2D) -> void:
	# Si Player está en el grupo Jugador
	# siempre está en este caso.
	if body.is_in_group("Jugador"):
	# Si Player tiene el método morir
	# se muere e imprime mensaje personalizado.
		if body.has_method("morir"):
			body.morir()
			print("¡Has muerto!")
			return;
