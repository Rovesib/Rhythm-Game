extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Load and play the song when the scene starts
	$Music.stream = load("res://SpotiDownloader.com - Dr Perky - Craig Maxx.mp3")
	$Music.play()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	# Get current song time (used later for syncing notes)
	var song_time = $Music.get_playback_position()
	print(song_time)
