extends Area
class_name Projectile

export var move_speed : float

var direction : Vector3

func initialize(direction : Vector3) -> void:
	self.direction = direction

func _ready() -> void:
	set_as_toplevel(true)
	connect("body_entered", self, "_on_body_entered")
	look_at(translation + direction, Vector3(0, 1, 0))

func _process(delta : float) -> void:
	translation += direction * move_speed * delta

func _on_body_entered(body) -> void:
	if body.is_a_parent_of(self):
		return
	queue_free()
