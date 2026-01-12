extends Node2D

# Makes note fall down screen
var speed = 300

func _process(delta):
	position.y += speed * delta

func set_lane(lane_index):
	match lane_index:
		0:     # Right
			rotation_degrees = 0      
		1:     # Down
			rotation_degrees = 90    
		2:     # Left
			rotation_degrees = 180    
		3:     # Up
			rotation_degrees = 270    
