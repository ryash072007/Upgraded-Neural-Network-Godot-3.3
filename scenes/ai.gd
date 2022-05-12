extends KinematicBody2D

var nn:NeuralNetwork = NeuralNetwork.new(8, 24, 4)

var speed: int = 500


func _ready() -> void:
	modulate = nn.color
	for child in $Raycasts.get_children():
		nn.add_raycast(child)
	
#	print(nn.get_prediction_from_raycasts())
func react_to_input():
	var output: Array = nn.get_prediction_from_raycasts()
	var velocity: Vector2
	if output[0] > 0.5: velocity.x += speed
	if output[1] > 0.5: velocity.x -= speed
	if output[2] > 0.5: velocity.y += speed
	if output[3] > 0.5: velocity.y -= speed
	velocity = move_and_slide(velocity)
	
func _physics_process(_delta: float) -> void:
	react_to_input()
#	print(nn.get_inputs_from_raycasts())

func add_fitness(value: float):
	nn.fitness += value


func _on_collision_area_body_entered(body: Node) -> void:
	if body is TileMap:
		call_deferred("kill")
