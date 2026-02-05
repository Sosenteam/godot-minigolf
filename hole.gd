extends Sprite2D


func _on_hole_area_body_entered(body: Node2D) -> void:
	if(get_node("../../PlayerBall").linear_velocity.length() < 300):
		EventBus.next_hole()
	
