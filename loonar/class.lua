-- Implementation of a class
-- Using lua metatable
-- 
function class(class_object)
  local events_map = {
    __index = '.', __newindex = '.=';
    __lt = '<', __le = '<=';
    --		__??? = '==';
    __add = '+', __sub = '-', __mul = '*', __div = '/', __pow = '^';
    __concat = '..';
    __call = '__call';
    --		__unm = '-';
    __gc = 'destroy';
    __tostring = 'tostring';
  }
  
  local class_object = class_object or {}
  
  function class_object.is_domain_of(instance)
    return class_object == getmetatable(instance).class
  end
  
  function class_object.is_subclass_of(class)
    return class == table
  end
  
  local constructor = function(self, attrs)
    for attr, value in attrs do self[attr] = value end
  end
  
  if 'function' == type(class_object[1]) then
    constructor = class_object[1] -- table.remove(class_object, 1)
  elseif class_object.initalize then
    constructor = class_object.initialize
  end
  
  local instance_protocol = { class = class_object }
  
  table.foreach(events_map, function(event, method)
    if 'function' == type(class_object[method]) then
      instance_protocol[event] = class_object[method]
    end
  end)
  
  -- Metatable definition for a class to observe events
  local class_protocol = {
    __call = function(self, ...)
      instance = {}
      
      setmetatable(instance, instance_protocol)
      constructor(instance, ...)
      
      return instance
    end
  }

  setmetatable(class_object, class_protocol)
  return class_object
end

-- vim:set ts=4 sw=4 sts=4 et:
