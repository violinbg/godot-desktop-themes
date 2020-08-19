extends WindowDialog

onready var optionButton = $TabContainer/Buttons/Control/OptionButton
onready var menuButton = $TabContainer/Buttons/Control/MenuButton
onready var progressBar = $TabContainer/Extra/ProgressBar
onready var tree = $TabContainer/Extra/Tree

func _ready():
	optionButton.add_item("Option 1")
	optionButton.add_item("Option 2")
	optionButton.add_item("Option 3")
	optionButton.add_item("Option 4")
	
	menuButton.get_popup().add_item("Item 1")
	menuButton.get_popup().add_item("Item 2")
	menuButton.get_popup().add_item("Item 3")
	menuButton.get_popup().add_item("Item 4")
	
	var root = tree.create_item()
	root.set_text(0, "Tree Root")
	var child1 = tree.create_item(root)
	child1.set_text(0, "Fruits")
	tree.create_item(child1).set_text(0, "Apple")
	tree.create_item(child1).set_text(0, "Oragne")
	tree.create_item(child1).set_text(0, "Banana")
	var child2 = tree.create_item(root)	
	child2.set_text(0, "Cars")
	tree.create_item(child2).set_text(0, "Audi")
	tree.create_item(child2).set_text(0, "Tesla")
	tree.create_item(child2).set_text(0, "Renaut")
	tree.create_item(child2).set_text(0, "Volvo")	

func _process(delta):
	progressBar.value += 10 * delta; # 10% per second
	if (progressBar.value >= 100):
		progressBar.value = 0


func _on_Dialog_hide():
	queue_free()

func _on_Dialog_gui_input(event):
	# Focus the dialog when user click on the title bar
	# Godot seems to not support well multiple windows 
	# or I can't figure out how to make them move on top when clicked.
	# This is still not idea. It only works if you click on the title bar.
	if event is InputEventMouseButton and event.button_index == BUTTON_LEFT and event.pressed:
		var parent = self.get_parent()
		parent.move_child(self, parent.get_child_count())
