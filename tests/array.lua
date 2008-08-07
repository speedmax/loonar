

list = a{11,22,33}

-- FIXME: This is failing because list[1] refer to numeric index
-- constructor function, so the __index overload never run for this one
-- need more research make class method never gets exposed
test.assert_equals(list[1], 11)

test.assert_equals(list[2], 22)
test.assert_equals(list[3], 33)

local sum = 0

list.each(function(key, value) 
	sum = sum + value
end)

test.assert_equals(11 + 22 + 33, sum)
