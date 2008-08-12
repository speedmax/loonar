
do -- Array access 
  local list = a{11,22,33}
  test.assert_equals(11, list[1])
  test.assert_equals(33, list[3])
  
  
  local list = array{111,222,333,444}
  test.assert_equals(111, list[1])
  test.assert_equals(222, list[2])
  test.assert_equals(333, list[3])
  
  test.assert_equals(111, list.first())
  test.assert_equals(444, list.last())
  
  local list = a{name='taylor', age = 26 }
  
  test.assert_equals(a{'name', 'age'}, list.keys())
  test.assert_equals(a{'taylor', 26}, list.values())
end

do -- Each iterator
  local sum = 0
  local list = a{111,222,333,444}

  list.each(function(value) 
    sum = sum + value
  end)
  
  test.assert_equals(111 + 222 + 333 + 444, sum)
end

do -- Map/Reduce
  local list = a{111,222,333,444}
  local result = list.map(function(value, key) 
    return value + 1
  end)
  test.assert_equals(result, a{112,223,334,445})

  local result = list.reduce(0, function(sum, value) 
    return sum + value
  end)
  test.assert_equals(111 + 222 + 333 + 444, result)
end

do -- Conditional iterator
  local list = a{111,222,333,444}
  
  -- Any
  test.assert_true(list.any(function(e) return e > 400 end))
  test.assert_false(list.any(function(e) return e > 500 end))

  -- All
  test.assert_true(list.all(function(e) return e > 1 end))
  test.assert_false(list.all(function(e) return e > 200 end))

  -- Contains
  test.assert_true(list.contains(333))
  test.assert_false(list.contains(3))
  
  -- Filter
  local result = list.filter(function(e) return e > 300 end)  
  test.assert_equals(result, a{333, 444})
  test.assert_false(result == a{})
end

-- vim:set ts=2 sw=2 sts=2 et:
