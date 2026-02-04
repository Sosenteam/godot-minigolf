extends RigidBody2D

@export var max_impulse = 400
@export var arrow_angle = 0.1
@export var arrow_tip_length = 0.8
@export var draw_scalar = 0.5

var color_gradient: Gradient = Gradient.new()
	
var mouse = {
	position = Vector2.ZERO,
	is_down = false,
	initial_position = Vector2.ZERO,
	drag_vector = Vector2.ZERO
}


func _ready() -> void:
	$ArrowBase.set_point_position(0,position)
	$ArrowBase.set_point_position(1,position)
	#set gradient color
	color_gradient.set_color(0.5,Color.GREEN)
	color_gradient.add_point(.8,Color.YELLOW)
	##color_gradient.set_color(1,Color.YELLOW)
	color_gradient.remove_point(1)
	color_gradient.add_point(1.0,Color.RED)



func _process(delta: float) -> void:
	#Set Drag_Vector and Limit it to max length
	mouse.drag_vector = mouse.position - mouse.initial_position
	mouse.drag_vector = mouse.drag_vector.limit_length(max_impulse)
	#Make Arrow Visible
	$ArrowBase.visible = mouse.is_down && mouse.drag_vector.length() > 20
	$ArrowBase/ArrowHeadLeft.visible = mouse.is_down && mouse.drag_vector.length() > 20
	$ArrowBase/ArrowHeadRight.visible = mouse.is_down && mouse.drag_vector.length() > 20
	#Draw Arrow/Set Line Points

	var final_angle = (-mouse.drag_vector).angle()
	var drag_length = (-mouse.drag_vector).length()
	var drawn_length = (-mouse.drag_vector).length()*draw_scalar
	var final_point = Vector2(0,0)-mouse.drag_vector*draw_scalar
	$ArrowBase.set_point_position(0,Vector2(0,0))
	$ArrowBase.set_point_position(1,final_point)
	
	$ArrowBase/ArrowHeadLeft.set_point_position(0,final_point)
	$ArrowBase/ArrowHeadLeft.set_point_position(1,Vector2.from_angle(final_angle+arrow_angle)*((drawn_length)*arrow_tip_length))
	$ArrowBase/ArrowHeadRight.set_point_position(0,final_point)
	$ArrowBase/ArrowHeadRight.set_point_position(1,Vector2.from_angle(final_angle-arrow_angle)*((drawn_length)*arrow_tip_length))
	#Set Color + Width
	var arrow_color = color_gradient.sample(remap(drag_length,0,max_impulse,0.0,1.0))
	$ArrowBase.default_color = arrow_color
	$ArrowBase/ArrowHeadLeft.default_color = arrow_color
	$ArrowBase/ArrowHeadRight.default_color = arrow_color
	var arrow_width = remap(drag_length,0,max_impulse,4,16)
	$ArrowBase.width = arrow_width
	$ArrowBase/ArrowHeadLeft.width = arrow_width
	$ArrowBase/ArrowHeadRight.width = arrow_width


func _input(event: InputEvent) -> void:
	if(event is InputEventMouseMotion):
		mouse.position = event.position
	if(event is InputEventMouseButton):
		if(!mouse.is_down && event.pressed):
			mouse.initial_position = event.position
		elif(mouse.is_down && !event.pressed):
			if(mouse.drag_vector.length() > 20):
				var new_impulse = -mouse.drag_vector
				apply_impulse(new_impulse)
		mouse.is_down = event.pressed 
		
		
	
