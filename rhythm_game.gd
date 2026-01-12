extends Node2D

# Load the Note scene so we can spawn notes
@onready var NoteScene = preload("res://Note.tscn")


# Times (in seconds) when notes should spawn
# Each entry = [time, lane_index]
var note_data = [
	
	[1.0, 1],
	[2.5, 2],
	[4.5, 2],
	[5.8, 3],
]

# Which note is next to spawn
var note_index = 0

# X positions for each lane
var lanes = [350, 500, 650, 750]

# Called when the node enters the scene tree for the first time
func _ready() -> void:
	# Load and play the song when the scene starts
	$Music.stream = load("res://SpotiDownloader.com - Dr Perky - Craig Maxx.mp3")
	$Music.play()

# Called every frame
func _process(delta: float) -> void:
	# Get current song time
	var song_time = $Music.get_playback_position()
	print(song_time)

# Spawn notes in order
	if note_index < note_data.size() and song_time >= note_data[note_index][0]:
		spawn_note(note_data[note_index][1])
		note_index += 1

# Creates and adds a note to the scene
func spawn_note(lane_index):
	var note = NoteScene.instantiate()
	note.position = Vector2(lanes[lane_index], -40)
	note.set_lane(lane_index)
	add_child(note)
