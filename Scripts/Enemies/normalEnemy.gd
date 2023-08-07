# normalEnemy.gd
extends baseEnemy

# Variables
export var forwardMotion: float
export var isVariant: bool
onready var projCreator = $projectileCreator

func startAction():
	motion = Vector2(-forwardMotion, 0)

	# Shooting, in variant mode
	if isVariant:
		yield(get_tree().create_timer(2, false),"timeout")
		var player = get_node("/root/Level/Player")
		if player:
			projCreator.targetShoot(0, player)
		else:
			projCreator.angleShoot(0, 180)
