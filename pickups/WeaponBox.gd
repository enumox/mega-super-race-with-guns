extends Area
class_name WeaponBox

const weapons = [
	preload("res://weapons/machine-gun/MachineGun.tscn")
]

func _ready() -> void:
	randomize()
	connect("body_entered", self, "_on_body_entered")

func _on_body_entered(body) -> void:
	if not body is BaseVehicle:
		return
	body.switch_weapon(weapons[randi() % weapons.size()])
	queue_free()
	