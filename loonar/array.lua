--
-- Array class
-- @class array : 
--    implements a array class
--    to provide enumerable traversal and searching methods

array = class {
  function(self, data)
    self.data = data
  end; 

  check = function(...)
    print(...)
  end;
    
  each = function(self, func)
    for k, v in pairs(self.data) do 
      func(v, k) 
    end
  end;

  print = function(self)
      table.foreach(self.data, print)
  end;
    
  ['.'] = function(self, key)
    if 'number' == type(key) then
      return self.data[key]
    else
      return self[key]
    end
  end
}

a = array

-- vim:set ts=2 sw=2 sts=2 et:
