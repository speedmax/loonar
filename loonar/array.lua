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

  ['.first'] = function(self)
    return self[1]
  end;
  
  ['.last'] = function(self)
    return self[#self]
  end;

  -- Manipulations

  cloned = function(self)
    cloned = a{}
    self.each(function(value)
      cloned.push(value)
    end)
    return cloned
  end;

  push = function(self, value)
    return table.insert(self, value)
  end;

  merge = function(self, value)
    local merged = self.cloned()
    value.each(merged.push)
    return merged
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

  flatten = function(self)
    local flattened = a{}

    self.each(function(value)
      if array.is_domain_of(value) then
	    value = value.flatten()
      else
	    value = a{value}
      end
	  flattened = flattened.merge(value)
    end)

    return flattened
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
