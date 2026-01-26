extends Node2D

var speed = 300
var lane_index = -1
var hit = false

func _process(delta):
	position.y += speed * delta
	
# If the note goes past the hit line → MISS
	if position.y > 670 and not hit:
		print("MISS")
		queue_free()

func set_lane(lane):
	var rotations = [180, 90, 270, 0]
	rotation_degrees = rotations[lane]
