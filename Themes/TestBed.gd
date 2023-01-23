extends Node

onready var dialog = $GUI/ControlsDialog
onready var acceptDialog = $GUI/AcceptDialog
onready var confirmDialog = $GUI/ConfirmationDialog
onready var fileDialog = $GUI/FileDialog
onready var themesCtrl = $GUI/TaskBar/Themes
onready var gui = $GUI

var themes = {
	0: ThemeItem.new("Default", "."),
	1: ThemeItem.new("Classic 3.11", "res://Themes/Classic311/Classic311.tres"),
	2: ThemeItem.new("Classic 95", "res://Themes/Classic95/Classic95.tres")
}

func _ready():
	for key in themes:
		var theme = themes[key]
		themesCtrl.add_item(theme.name, key)
	changeTheme(2) # pre-select Classic 95

func changeTheme(index):
	themesCtrl.select(index) 
	_on_Themes_item_selected(index)

func _on_Button_button_up():
	#dialog.visible = true
	var new_dialog = dialog.duplicate()
	gui.add_child(new_dialog)
	new_dialog.visible = true


class ThemeItem:
	var name = ""
	var source = ""
	
	func _init(name, source):
		self.name = name;
		self.source = source;


func _on_Themes_item_selected(index):
	var themeResource = themes[index].source
	if themeResource == ".":
		gui.theme = null
	else:
		gui.theme = load(themeResource)

func _on_Alert_button_up():
	putOnTop(acceptDialog)
	acceptDialog.visible = true


func _on_Confirm_button_up():
	putOnTop(confirmDialog)
	confirmDialog.visible = true


func _on_File_button_up():
	putOnTop(fileDialog)
	fileDialog.visible = true
	
func putOnTop(control):
	var parent = control.get_parent()
	parent.move_child(control, parent.get_child_count())
