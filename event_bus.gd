extends Node

var score: int = 0
var level: int = 0
var current_scene
var current_scene_id;
var level_data_resource;
var current_score = 0
var total_score = 0

func _ready():
	level_data_resource = load("res://levels/level_data.tres")

func next_hole():
	total_score+=current_score
	current_score = 0
	level+= 1
	if(level < level_data_resource.levels.size()):
		get_tree().change_scene_to_packed(level_data_resource.levels[level])
	else:
		current_score = total_score
