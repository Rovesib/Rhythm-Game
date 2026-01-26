extends Node2D

# Load the Note scene so we can spawn notes
@onready var NoteScene = preload("res://Note.tscn")

# X positions for each lane (left → right)
var lanes = [350, 440, 530, 630]

# Song tempo (change this to match the song)
var bpm = 90

# Seconds per beat (calculated from BPM)
var seconds_per_beat = 60.0 / bpm

# Track the current beat
var current_beat = -1

# Prevents multiple spawns on the same beat
var last_spawned_beat = -1

# Spawn a note every X beats
var beats_per_note = 2


func _ready() -> void:
	randomize()
	$Music.stream = load("res://SpotiDownloader.com - Dr Perky - Craig Maxx.mp3")
	$Music.play()


func _process(delta: float) -> void:
	var song_time = $Music.get_playback_position()

	# Calculate which beat we're on
	var beat = int(song_time / seconds_per_beat)

	# Only run logic when the beat changes
	if beat != current_beat:
		current_beat = beat

		# Spawn once per beat interval
		if current_beat % beats_per_note == 0 and current_beat != last_spawned_beat:
			last_spawned_beat = current_beat
			spawn_note(randi() % lanes.size())


func _unhandled_input(event):
	if event.is_action_pressed("Lane_0"):
		check_hit(0)
	if event.is_action_pressed("Lane_1"):
		check_hit(1)
	if event.is_action_pressed("Lane_2"):
		check_hit(2)
	if event.is_action_pressed("Lane_3"):
		check_hit(3)


# Spawns a note in a specific lane
func spawn_note(lane_index):
	var note = NoteScene.instantiate()
	note.position = Vector2(lanes[lane_index], -40)
	note.lane_index = lane_index
	note.set_lane(lane_index)
	add_child(note)


# Checks if a note was hit near the hit line
func check_hit(lane):
	for note in get_children():
		if note.is_in_group("notes") and note.lane_index == lane:
			var distance = abs(note.position.y - $HitLine.position.y)
			if distance < 50:
				note.queue_free()
				print("HIT")
				return

	print("MISS")
