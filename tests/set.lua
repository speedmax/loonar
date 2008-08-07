
list = Set {111,222,333,444}

test.assert_true(list[1], 111)

test.assert_true(list[4], 444)

test.assert_false(list[5], 555)