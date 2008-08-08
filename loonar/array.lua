-- Array class
-- For array or hash like object 
-- to provide enumerable traversal and searching methods

Array = class {
  
  function(self, data)
    self.data = data
  end, 

  check = function(...)
    print(...)
  end;
    
  each = function(self, func)
    for k, v in pairs(self.data) do 
      func(v, k) 
    end
  end,

  print = function(self)
      table.foreach(self.data, print)
  end,
    
  ['.'] = function(self, key)
    if 'number' == type(key) then
      return self.data[key]
    else
      return self[key]
    end
  end
}
a = Array
