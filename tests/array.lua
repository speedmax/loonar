
--[[
list = array({111,222,333,444})

test.assert_equals(111, list[1])

test.assert_equals(444, list[4])
test.assert_false(555 == list[5])


array.each({1,2,3}, function(e) print 'hello' end)

sum = 0
list.each(function(e) sum = sum + e end)
test.assert_equals(111 + 222 + 333 + 444, sum)
]]--
