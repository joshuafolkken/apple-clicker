extends Sprite2D

const TREE_APPLE_COST = 10
const CLICK_POWER_COST = 100

const TREE_APPLE = 2
const CLICK_POWER = 1

var apple_count := 0
var tree_count := 0
var click_power_count := 1

@onready var label: Label = get_parent().get_node("AppleText")


func _process(_delta: float) -> void:
	label.text = "%d apples" % apple_count


func _get_tree_apple_count() -> int:
	return tree_count * TREE_APPLE


func _show_buy_button_text() -> void:
	var buy_button: Button = get_parent().get_node("UpgradeButton")
	buy_button.text = "りんごの木 x %d\n(%d apples)" % [tree_count, TREE_APPLE_COST]


func _get_click_power_count() -> int:
	return click_power_count * CLICK_POWER


func _show_click_power_button_text() -> void:
	var click_power_button: Button = get_parent().get_node("ClickPowerButton")
	click_power_button.text = ("クリックパワー x %d\n(%d apples)" % [click_power_count, CLICK_POWER_COST])


func _ready() -> void:
	print("hello world!")
	print(apple_count)
	_show_buy_button_text()
	_show_click_power_button_text()

	while true:
		await get_tree().create_timer(1.0).timeout
		apple_count += _get_tree_apple_count()


func _is_input_mouse_left_button(event: InputEvent) -> bool:
	if event is not InputEventMouseButton:
		return false

	var mouse_button_event: InputEventMouseButton = event

	if mouse_button_event.button_index != MOUSE_BUTTON_LEFT:
		return false

	if not mouse_button_event.pressed:
		return false

	return true


func _input(event: InputEvent) -> void:
	if _is_input_mouse_left_button(event):
		apple_count += click_power_count
		print(apple_count)

		if 10 == apple_count:
			print("やったー")


func _on_button_pressed() -> void:
	if apple_count < TREE_APPLE_COST:
		return

	apple_count -= TREE_APPLE_COST
	tree_count += 1
	_show_buy_button_text()


func _on_click_power_button_pressed() -> void:
	if apple_count < CLICK_POWER_COST:
		return

	apple_count -= CLICK_POWER_COST
	click_power_count += CLICK_POWER
	_show_click_power_button_text()
