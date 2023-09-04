extends Node

@onready var themesCtrl = $GUI/TaskBar/Themes
@onready var gui = $GUI
@onready var controlsDialog = preload ("res://Themes/TestDialog.tscn")

var themes = {
	0: ThemeItem.new("Default", "."),
	1: ThemeItem.new("Classic 3.11", "res://Themes/Classic311/Classic311.tres"),
	2: ThemeItem.new("Classic 95", "res://Themes/Classic95/Classic95.tres"),
	3: ThemeItem.new("Modern 11 (WIP)", "res://Themes/Modern11/Modern11.tres")
}

func _ready():
	for key in themes:
		var theme = themes[key]
		themesCtrl.add_item(theme.name, key)
	changeTheme(2) # pre-select Classic 95
	#changeTheme(3) # pre-select Modern 11

func changeTheme(index):
	themesCtrl.select(index) 
	_on_Themes_item_selected(index)

func _on_Button_button_up():
	var window = Window.new()
	window.title = "Controls Demo"	
	window.initial_position = Window.WINDOW_INITIAL_POSITION_CENTER_MAIN_WINDOW_SCREEN
	window.visible = true
	window.size.x = 595
	window.size.y = 380	
	window.close_requested.connect(window.queue_free)
	window.add_child(controlsDialog.instantiate())
	
	gui.add_child(window)

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
	var dialog = AcceptDialog.new()
	dialog.title = "Alert"
	dialog.initial_position = Window.WINDOW_INITIAL_POSITION_CENTER_MAIN_WINDOW_SCREEN
	dialog.size = Vector2i(200, 100)
	dialog.dialog_hide_on_ok = true
	dialog.dialog_close_on_escape = true
	dialog.dialog_text = "Hello World"
	dialog.visible = true
	gui.add_child(dialog)


func _on_Confirm_button_up():
	var dialog = ConfirmationDialog.new()
	dialog.title = "Please confirm"
	dialog.initial_position = Window.WINDOW_INITIAL_POSITION_CENTER_MAIN_WINDOW_SCREEN
	dialog.size = Vector2i(200, 100)
	dialog.dialog_hide_on_ok = true
	dialog.dialog_close_on_escape = true
	dialog.dialog_text = "This is a dialog. Ok?"
	dialog.visible = true
	gui.add_child(dialog)


func _on_File_button_up():
	var dialog = FileDialog.new()
	dialog.title = "Save a file"
	dialog.initial_position = Window.WINDOW_INITIAL_POSITION_CENTER_MAIN_WINDOW_SCREEN
	dialog.size = Vector2i(720, 450)
	dialog.dialog_hide_on_ok = true
	dialog.dialog_close_on_escape = true
	dialog.visible = true
	gui.add_child(dialog)
	
func putOnTop(control):
	var parent = control.get_parent()
	parent.move_child(control, parent.get_child_count())
