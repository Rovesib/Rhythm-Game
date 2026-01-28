extends Node2D

var speed = 300
var lane_index = -1
var hit = false

func _process(delta):
	position.y += speed * delta

	if position.y > 670 and not hit:
		hit = true
		print("MISS")
		get_parent().register_miss()
		queue_free()


	# make notes face different ways
func set_lane(lane):
	var rotations = [180, 90, 270, 0]
	rotation_degrees = rotations[lane]
