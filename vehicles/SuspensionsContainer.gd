tool
extends Spatial
class_name SuspensionsContainer

const WHEEL_SCENE = preload("res://vehicles/wheels/WheelMesh.tscn")

export var length : = 1.0 setget set_length
export var force : = 5.0

func _ready() -> void:
	if Engine.is_editor_hint():
		return
	for suspension in get_children():
		var wheel = WHEEL_SCENE.instance()
		if suspension.name.to_lower().ends_with("right"):
			wheel.rotation_degrees.y = 180
		suspension.add_child(wheel)

func _physics_process(delta : float) -> void:
	if Engine.is_editor_hint():
		return
	for suspension in get_children():
		if suspension.is_colliding():
			suspension.get_child(0).global_transform.origin = suspension.get_collision_point()
		else:
			suspension.get_child(0).global_transform.origin = suspension.global_transform.origin + suspension.cast_to

func set_length(new_value : float) -> void:
	length = new_value
	for suspension in get_children():
		suspension.cast_to = Vector3(0, -1, 0) * length
