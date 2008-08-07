list = a{11,22,33}

test.assert_equals(list[1], 11)

test.assert_equals(list[2], 22)
test.assert_equals(list[3], 33)

local sum = 0

list.each(function(value) 
	sum = sum + value
end)

test.assert_equals(11 + 22 + 33, sum)
