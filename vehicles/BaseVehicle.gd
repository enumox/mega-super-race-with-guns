extends RigidBody
class_name BaseVehicle

export(float, 0.1, 10.0) var acceleration : float
export(float, 0.1, 10.0) var steer_speed : float = 0.2
export(float, 0.1, 50.0) var tyres_grip : float
export var steer_force : int = 25
export var speed : int
export var current_camera : NodePath

onready var suspensions_container : = $SuspensionsContainer
onready var force_position : = $ForcePosition
onready var weapon_mounting : = $WeaponMounting

var suspensions = []
var current_steer : float = 0
var current_gas : float = 0

func _ready() -> void:
	suspensions = suspensions_container.get_children()

func _physics_process(delta : float) -> void:
	var gas = int(Input.is_action_pressed("move_forward")) - int(Input.is_action_pressed("move_backward"))
	current_gas = lerp(current_gas, gas, acceleration * delta)
	print(current_gas)
	var steer = int(Input.is_action_pressed("move_right")) - int(Input.is_action_pressed("move_left"))
	current_steer = lerp(current_steer, steer_force * -steer, steer_speed)
	
	if current_gas > 0.01: #Only steer when moving like a real car
		add_torque(Vector3(0, 1, 0) * current_steer * steer_speed)
	add_force(Vector3(0, 0, 1).rotated(Vector3(0, 1, 0), rotation.y) * speed * current_gas,\
		force_position.translation.rotated(Vector3(0, 1, 0), rotation.y))
	
	add_force(Vector3(-1, 0, 0).rotated(Vector3(0, 1, 0), rotation.y) * tyres_grip * steer * abs(current_gas), Vector3())
	
	for suspension in suspensions:
		if suspension.is_colliding():
			var distance = suspension.get_collision_point().distance_to(suspension.global_transform.origin)
			var applied_force = (suspensions_container.length - distance) / suspensions_container.length
			add_force(Vector3(0, 1, 0) * (suspensions_container.force * applied_force), suspension.translation.rotated(Vector3(0,1,0), rotation.y))

func switch_weapon(new_weapon : Resource) -> void:
	if weapon_mounting.get_child_count() > 0:
		weapon_mounting.get_child(0).queue_free()
	var weapon = new_weapon.instance()
	weapon.initialize(get_node(current_camera))
	weapon_mounting.add_child(weapon)
	weapon.translation = Vector3()
