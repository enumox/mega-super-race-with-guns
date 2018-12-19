extends Spatial

export(int, 1, 10) var fire_rate : int
export var ammo : int
export var damage : int
export var projectile : PackedScene

onready var timer : = $Timer as Timer
onready var mesh : = $Mesh as Spatial

var camera : Camera

func initialize(current_camera : Camera) -> void:
	camera = current_camera

func _ready() -> void:
	randomize()
	timer.wait_time = 1 / fire_rate

func _process(delta : float) -> void:
	if Input.is_action_pressed("shoot") and timer.is_stopped():
		_shoot()

func _physics_process(delta : float) -> void:
	var origin = camera.project_ray_origin(get_viewport().get_mouse_position())
	var direction = camera.project_ray_normal(get_viewport().get_mouse_position())
	var space_state = get_world().get_direct_space_state()
	var hit = space_state.intersect_ray(origin, origin + direction * 1000.0)
	if hit.size() > 0:
		mesh.look_at(Vector3(hit.position.x, global_transform.origin.y, hit.position.z), Vector3(0, 1, 0))

func _shoot() -> void:
	pass
