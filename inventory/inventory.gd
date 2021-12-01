extends Resource
class_name Inventory

signal items_changed(indexes)

export(Array, Resource) var items = [
	null, null, null, null, null, null, null, null, null
]

func set_item(item_index, item):
	var previousItem = items[item_index]
	items[item_index] = item

func find_index():
	for i in items.size():
		if items[i] == null:
			return i
	return -1
