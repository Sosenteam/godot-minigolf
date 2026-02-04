extends Node

var score: int = 0
var level: int = 0
var current_scene
var current_scene_id;
var level_data_resource
func _ready():
	level_data_resource = load("res://levels/level_data.tres")

func next_hole():
	level+= 1
	get_tree().change_scene_to_packed(level_data_resource.levels[level])
