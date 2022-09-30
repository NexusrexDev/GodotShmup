# chargerEnemy.gd
extends baseEnemy

# Variables
export var forwardMotion: Vector2
export var chargeTime: float = 0.5
onready var projectileCreator = $projectileCreator

func startAction():
	# Start charging
	# -Charging animation code goes here-
	yield(get_tree().create_timer(chargeTime),"timeout")
	# Blast off!
	for _i in range(3):
		var player = get_node("/root/Level/Player")
		if player:
			projectileCreator.shoot(0, projectileCreator.AT_OBJECT, 1, 0, player)
		else:
			projectileCreator.shoot(0, projectileCreator.ANGLE, 1, 180)
		yield(get_tree().create_timer(0.15),"timeout")
	# Move on
	var tempTween = get_tree().create_tween()
	tempTween.tween_property(self, "motion", forwardMotion, 0.2)
