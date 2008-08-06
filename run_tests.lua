#!/usr/bin/env lua
-- Load darl 
require 'darl.class'
require 'darl.object'
require 'darl.set'

require 'tests.test'
require 'tests.class'
require 'tests.object'
require 'tests.set_test'

-- Helper functions for __LINE__ and __FILE__
function __FILE__() return debug.getinfo(2,'S').source end
function __LINE__() return debug.getinfo(2, 'l').currentline end


-- Execute all tests
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
