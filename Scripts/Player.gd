# Player.gd
extends KinematicBody2D

# Variables
var health : int = 3
export var speed = 250
var motion : Vector2 = Vector2.ZERO
export var canControl : bool = false
var lerpValue : float = .35
onready var projectileCreator = $projectileCreator
onready var shootTimer = $shootTimer
onready var invisTimer = $iframeTimer

signal healthChange(value)
signal death()

func _ready():
	pass
	#canControl = false

func _process(_delta):
	if canControl:
		if Input.is_action_pressed("ui_accept"):
			shooting()

func _physics_process(_delta):
	# Movement
	if canControl:
		var x_input = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
		var y_input = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	
		if x_input != 0:
			motion.x = lerp(motion.x, x_input, lerpValue)
		else:
			motion.x = lerp(motion.x, 0, lerpValue)
		
		if y_input != 0:
			motion.y = lerp(motion.y, y_input, lerpValue)
		else:
			motion.y = lerp(motion.y, 0, lerpValue)
	
	move_and_slide(motion * speed)

func shooting():
	if shootTimer.is_stopped():
		projectileCreator.angleShoot(0)
		shootTimer.start()

func damage():
	if invisTimer.is_stopped():
		health -= 1
		emit_signal("healthChange", health)
		invisTimer.start()
		if health <= 0:
			emit_signal("death")
			queue_free()

func enableControl():
	canControl = true

func _on_DamageBox_area_entered(area):
	if area.is_in_group("enemy"):
		damage()
