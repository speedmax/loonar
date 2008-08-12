--
-- @class array : 
--    Implements array access and collection methods for array object
--

array = class {
  function(self, data)
    for k, v in pairs(data) do 
      self[k] = v
    end
  end; 
  
  first = function(self)
    return self[1]
  end;
  
  last = function(self)
    return self[#self]
  end;
  
  -- Note: are this for Hash only?
  keys = function(self)
    return self.map(function(value, key) 
      return key 
    end)
  end;
  
  values = function(self)
    return self.map(function(value) 
      return value 
    end)
  end;
  
  -- Manipulations
  push = function(self, value)
    return table.insert(self, value)
  end;

  shift = function(self)
    return table.remove(self, 1)
  end;
  
  pop = function(self)
    return table.remove(self)
  end;
  
  unshift = function(self)
    return table.insert(self, 1, value)
  end;
  
  -- conditional
  contains = function(self, item)
    for k, v in pairs(self) do
      if item == v then
        return true
      end
    end
    return false
  end;
  
  any = function(self, func)
    for k, v in pairs(self) do
      if func(v, k) == true then
        return true
      end
    end
    return false
  end;
  
  all = function(self, func)
    for k, v in pairs(self) do
      if func(v, k) == false then
        return false
      end
    end
    return true
  end;
  
  -- Collection methods
  each = function(self, func)
    for k, v in pairs(self) do 
      func(v, k) 
    end
  end;

  map = function(self, func) 
    local results = a{}
    for k, v in pairs(self) do 
      results.push(func(v, k))
    end
    return results
  end;
  
  reduce = function(self, initial, func) 
    local result = initial
    for k, v in pairs(self) do 
      result = func(result, v) 
    end
    return result
  end;
  
  filter = function(self, func)
    local results = a{}
    for k, v in pairs(self) do
      if func(v, k) == true then
        results.push(v)
      end
    end
    return results
  end;
  
  ['.'] = function(self, key)
		if rawget(self, key) then
    	return self[key]
		end
		return false
  end;
  
  -- FIXEME: equality test should be recursive solution against their value
  ['=='] = function(self, operand)
    return table.show(self) == table.show(operand)
  end;

  tostring = function(self) 
    return table.show(self, 'array')
  end;
}

a = array

-- vim:set ts=2 sw=2 sts=2 et:
