
test = { fails = {} }

function test.fail(message)
    table.insert(test.fails, { message = message, trace = debug.traceback() })
end

function test.assert(condition, message)
    if not condition then
        local value = tostring(condition)
        test.fail(message or "condition should be true, not " .. value)
    end

    return condition
end

test.assert_true = test.assert

function test.assert_false(condition, message)
    local value = tostring(condition)

    test.assert(
        not condition,
        message or "condition should be false, not " .. value
    )

    return condition
end

function test.assert_equals(expected, actual, message)
    message = message or
        "expected " .. tostring(expected) .. ", not " .. tostring(actual)

    test.assert(expected == actual, message)
    return expected
end

function test.assert_length(expected_length, container, message)
    message = message or
        "expected " .. expected_length .. " of elements, not " .. #container

    test.assert_equals(expected_length, #container, message)
    return container
end

-- metatests:

do -- test assert()
    local init = #test.fails

    test.fail()
    test.assert(
        init + 1 == #test.fails,
        "test.fail() should append test.fail table"
    )
    test.fails[#test.fails] = nil
end

do
    local init = #test.fails

    test.assert(true, "assert(true) should do nothing")
    test.assert(init == #test.fails)

    test.assert(false)
    test.assert(
        init + 1 == #test.fails,
        "assert(false) should append test.fail table"
    )
    test.fails[#test.fails] = nil

    test.assert(nil)
    test.assert(
        init + 1 == #test.fails,
        "assert(nil) should append test.fail table"
    )
    test.fails[#test.fails] = nil
end

do -- test assert_false()
    local init = #test.fails

    test.assert_false(false)
    test.assert(init == #test.fails, "assert_false(false) should do nothing)")

    test.assert_false(nil)
    test.assert(init == #test.fails, "assert_false(nil) should do nothing)")

    test.assert_false(true)
    test.assert(
        init + 1 == #test.fails,
        "assert_false(true) should append test.fail table"
    )
    test.fails[#test.fails] = nil
end

do -- test assert_equals()
    local init = #test.fails

    test.assert_equals(1, 1, "assert_equals(1, 1) should do nothing")

    test.assert_equals(1, 2)
    test.assert(
        init + 1 == #test.fails,
        "assert_false(true) should append test.fail table"
    )
    test.fails[#test.fails] = nil
end

do -- test assert_length()
    local init = #test.fails

    test.assert_length(0, {})
    test.assert_length(1, {1})
    test.assert_length(2, {1, 2})

    test.assert_length(1, {})
    test.assert_equals(
        init + 1, #test.fails,
        "assert_length(1, {}) should append test.fail table"
    )
    test.fails[#test.fails] = nil

    test.assert_length(0, {1, 2})
    test.assert_equals(
        init + 1, #test.fails,
        "assert_length(0, {1, 2}) should append test.fail table"
    )
    test.fails[#test.fails] = nil
end

-- vim:set ts=4 sw=4 sts=4 et:
