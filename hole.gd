extends Sprite2D


func _on_hole_area_body_entered(body: Node2D) -> void:
	EventBus.next_hole()
	
