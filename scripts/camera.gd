extends Camera2D

@export var look_ahead_distance := 30.0   # How far camera moves toward mouse
@export var follow_speed := 5.0            # Camera smoothing speed
@export var min_zoom := 6.0                # Zoomed in
@export var max_zoom := 4.0                # Zoomed out
@export var max_look_distance := 30.0    # Mouse distance that triggers full zoom out
@export var zoom_lerp_speed := 5.0        # Smooth zoom speed

var player: Node2D = null

func _ready():
	# assuming camera is child of Diver
	player = get_parent()
	limit_smoothed = true
	zoom = Vector2(min_zoom, min_zoom)

func _process(delta):
	if not player:
		return

	# --- Step 1: get global mouse position ---
	var mouse_pos = get_global_mouse_position()

	# --- Step 2: calculate direction and target position ---
	var direction = (mouse_pos - player.global_position)
	direction = direction.limit_length(look_ahead_distance)
	var target_pos = player.global_position + direction

	# --- Step 3: smooth follow ---
	global_position = global_position.lerp(target_pos, follow_speed * delta)

	# --- Step 4: clamp camera to map boundaries ---
	global_position.x = clamp(global_position.x, limit_left, limit_right)
	global_position.y = clamp(global_position.y, limit_top, limit_bottom)

	# --- Step 5: dynamic zoom based on mouse distance ---
	var look_distance = (mouse_pos - player.global_position).length()
	var target_zoom_val = lerp(min_zoom, max_zoom, clamp(look_distance / max_look_distance, 0, 1))
	zoom = zoom.lerp(Vector2(target_zoom_val, target_zoom_val), zoom_lerp_speed * delta)
