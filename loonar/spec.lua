--[[
Lua spec
    Provide excutable specification

Explaination:
  - a spec can have one or more context 
  - a context have one or more examples
  - a example have one or more expectations

Example:
  -- Describe a context
  describe ("string")
  {
    -- setup [optional]
    before = function(self)
      self.value = "hello world"
    end;
   
    -- This is a example
    ["transforms to upper case"] = function(self)
      expect(self.value:upper()).should_be 'HELLO WORLD' -- Expectation
    end;
    
    -- Another example
    ["matches pattern"] = function(self)
      expect(self.value).should_match 'world'
      expect(self.value).should_match 'hello'
    end;
    
    -- cleanup [optional]
    after = function() end
  }
  
Limitation:
  - lua store hash alphabetically with key, so our context executed
    alphabetically, example in a context executed alphabetically
--]]

spec = {
  contexts = {}, passed = 0, failed = 0, verbose = false, current = nil
}

-- Report spec failure and success rates
spec.report = function ()
  local total = spec.passed + spec.failed
  local percent = spec.passed/total*100
  local summery
  if spec.failed == 0 and not spec.verbose then
    print "all tests passed"
    return
  end
  
  for context, cases in pairs(spec.contexts) do
    print (("%s\n================================"):format(context))
    for description, result in pairs(cases) do
      local outcome = result.passed and 'pass' or "FAILED"

      if spec.verbose or not (spec.verbose and result.passed) then
        print(("%-70s [ %s ]"):format(" - " .. description, outcome))

        table.foreach(result.errors, function(index, error)
          print ("   ".. index..". Failed expectation : ".. error.message.."\n   "..error.trace)
        end)
      end
    end
  end
  
  summery = [[
=========  Summery  ============
  %s Expectations
    Passed : %s, Failed : %s, Success rate : %.2f percent
  ]]
  
  print (summery:format(total, spec.passed, spec.failed, percent))
end

spec.add_example = function()
end;

spec.add_expectation = function()
end;

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
  local executor = function (self, method)
    return function(...)
      if not matchers[method] then
        return nil
      end

      local success, message = matchers[method](self, ...)
      spec.current.passed = success

      if success then
        spec.passed = spec.passed + 1
      else
        table.insert(spec.current.errors , { message = message, trace = debug.traceback()} )
        spec.failed = spec.failed + 1
      end
    end
  end

  setmetatable(instance, { __index = executor })
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
    for description, example in pairs(specs) do
      spec.contexts[context][description] = { 
        passed = false, errors = {}
      }
      spec.current = spec.contexts[context][description]
      example(instance)
    end
 
    -- post routine
    if after then
      after(instance)
    end
  end
end


