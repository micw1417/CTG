extends AudioStreamPlayer

var last_pitch = 1;

@warning_ignore("native_method_override")
func play(from_position=0.0):
	randomize()
	pitch_scale = randf_range(.8, 1.2)
	
	while abs(pitch_scale - last_pitch < .1):
		randomize()
		pitch_scale = randf_range(.8, 1.2)
	last_pitch = pitch_scale
