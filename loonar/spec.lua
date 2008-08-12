-- Lua spec
--		Provide excutable specification
--
-- Limitation:
--		lua seem to order the key when using table as hash to store specs
--		So its out of order, but shouldn't affect us	

-- Example:
----------------------
-- describe ("string")
-- {
-- 
--   before = function(self)
--     self.value = "hello world"
--   end;
--  
--   ["transforms to upper case"] = function(self)
--     expect(self.value:upper()).should_be 'HELLO WORLD'
--   end;
-- 
--   ["matches pattern /hello/"] = function(self)
--    
--     expect(self.value).should_match 'hello'
--   end;
-- 
--   after = function() end
-- }


spec = {
  contexts = {}, passed = 0, failed = 0, verbose = false, current = nil
}

-- Report spec failure and success rates
spec.report = function ()
	local total = spec.passed + spec.failed
	local percent = spec.passed/total*100
	
	if spec.failed == 0 and not spec.verbose then
		print "all tests passed"
		return
	end
	
	for context, cases in pairs(spec.contexts) do
		print (context)
		print "================================"
		
		for description, result in pairs(cases) do
			local outcome = result.passed and 'passed' or "failed"
			
			if spec.verbose or (not spec.verbose and not result.passed) then
				print (" - "..description.." :\t\t[ "..outcome.." ]")
				print "   ----------------------------"

				if not result.passed and result.trace then
					print ("   message :\n\t".. result.message.."\n   "..result.trace)
				end
			end
		end
	end
	
	print (total.." Expectations ")
	print (string.format("  Passed : %s Failed : %s Success rate : %.2f percent", spec.passed, spec.failed, percent))
	print '================================'
end

--
-- Collection of should matchers
 
matchers = {
  should_be = function(self, expected)
    if self.value ~= expected then
      return false, "expecting "..tostring(expected)..", not ".. tostring(self.value)
    end
    return true
  end;
  
  should_be_true = function(self)
		if self.value ~= true then
			return false, "expecting true, not " .. self.value
		end
		return true
  end;
  
  should_be_false = function(self) 
		if self.value ~= false then
			return false, "expecting false, not " .. self.value
		end
		return true
	end;
	
  should_be_nil = function(self) 
		if self.value ~= nil then
			return false, "expecting nil, not " ..self.value
		end
		return true
	end;
	
  should_not_be = function(self, expected)
		if self.value == expected then
			return false, "should not be "..self.value
		end
		return true
	end;

  should_match = function(self, pattern) 
		if type(self.value) ~= 'string' then
			return false, "type error, should_match expecting target as string"
		end
		
		if not string.match(self.value, pattern) then
			return false, self.value .. "doesn't match pattern "..pattern
		end
		return true
	end;	
}
 
matchers.should_equal = matchers.should_be

-- Expectation function
--
function expect(target)
  local instance = { value = target }  

  local expectation = function (self, method)
		return function(...)
      if not matchers[method] then
				return nil
			end

			local success, message = matchers[method](self, ...)

			if success then
				spec.current.passed = true
				spec.passed = spec.passed + 1
			else
				spec.current.passed = false
				spec.current.message = message
				spec.current.trace = debug.traceback()
				spec.failed = spec.failed + 1
			end
    end
  end

  setmetatable(instance, { __index = expectation })
  return instance
end
 
function type_of(target)
	return expect(type(target))
end

value_of = expect

-- Descript a context
-- 
function describe(context)
  spec.contexts[context] = {}
  
  return function(specs)
    local instance = {}
    local before = specs.before and specs.before or nil
    local after = specs.after and specs.after or nil
    
    -- prepare
    if before then
      specs.before = nil
      before(instance)
    end
    if after then
      specs.after = nil
    end

    -- run
    for description, testcase in pairs(specs) do
      spec.contexts[context][description] = { 
				passed = false, message = nil, trace = nil
			}
      spec.current = spec.contexts[context][description]
      testcase(instance)
    end
 
    -- post routine
    if after then
      after(instance)
    end
  end
end
 
 

