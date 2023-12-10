extends TileMap
var spawns : Array

# Called when the node enters the scene tree for the first time.
func _ready():
	spawns  = $Spawns.get_children() 


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
