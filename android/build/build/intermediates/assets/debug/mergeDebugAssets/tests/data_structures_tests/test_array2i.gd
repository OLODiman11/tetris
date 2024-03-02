extends GutTest

var get_set_items_params = [
	[0, 0, 3], [0, 9, -2], [9, 0, -10], [9, 9, 1]
	]

func test_get_set_item(params=use_parameters(get_set_items_params)):
	var array = Array2i.new(10, 10)
	var row: int = params[0]
	var col: int = params[1]
	var value: int = params[2]
	
	array.set_item(row, col, value)
	var sut := array.get_item(row, col)
	
	assert_eq(sut, value)
	
func test_eq():
	var arr1 = Array2i.new(10, 10)
	var arr2 = Array2i.new(10, 10)
	
	assert_true(arr1.eq(arr2))
