#!/usr/bin/env lua
require 'test'
require 'class'
require 'object'

for i = 1, #test.fails do
    local fail = test.fails[i]
    print(i .. ". " .. fail.message)
    print(fail.trace)
end

if #test.fails == 1 then
	print("1 test failed!")
elseif #test.fails > 1 then
	print(#test.fails .. " tests failed!")
else
	print "all tests succeed!"
end

-- vim:set ts=4 sw=4 sts=4 et:
