hash = class {
  function(self, data)
    for k, v in pairs(data) do 
      self[k] = v
    end
  end;

  ['.keys'] = function(self)
    return self.map(function(value, key) 
      return key 
    end)
  end;
  
  ['.values'] = function(self)
    return self.map(function(value) 
      return value 
    end)
  end;
  
  -- conditional
  has_key = function(self, key)
    return self[key] ~= nil
  end;
  
  contains = function(self, item)
    for k, v in pairs(self) do
      if item == v then
        return true
      end
    end
    return false
  end;
  
  each = function(self, func)
    for k, v in pairs(self) do 
      func(v, k) 
    end
  end;

  map = function(self, func) 
    local results = h{}
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
    local results = h{}
    for k, v in pairs(self) do
      if func(v, k) == true then
        results[k] = v
      end
    end
    return results
  end;
  
  tostring = function(self) 
    return table.show(self, 'hash')
  end;
}

h = hash