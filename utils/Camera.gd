extends Camera

export var follow_path : NodePath
export var follow_speed : float
export(float, EASE) var easing = 1.0

const FOLLOW_OFFSET = Vector3(0, 0, 15)

var follow
var speed

func _ready() -> void:
	follow = get_node(follow_path)

func _process(delta : float) -> void:
	var target = Vector3(follow.global_transform.origin.x, global_transform.origin.y, follow.global_transform.origin.z)
	target += FOLLOW_OFFSET
	global_transform.origin = global_transform.origin.linear_interpolate(target, follow_speed * delta * ease(0.5, easing))
