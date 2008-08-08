
list = a{11,22,33}

-- Index overloading is not working yet
test.assert_equals(11, list.data[1])
test.assert_equals(list.data[1], list[1])

list = array({111,222,333,444})
test.assert_equals(111, list[1])
test.assert_equals(222, list[2])
test.assert_equals(333, list[3])

local sum = 0

--[[
list.each(function(value) 
  sum = sum + value
end)

test.assert_equals(11 + 22 + 33, sum)
]]--

-- vim:set ts=2 sw=2 sts=2 et:
