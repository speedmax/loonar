-- 
-- Implementation of a class
-- @func class : responsible of class and object creation
-- returns
--    @param class_object: object class
function class(class_object)
  local events_map = {
    -- Getter and Setters
    __index = '.', __newindex = '.=';
    -- Comparision
    __lt = '<', __le = '<=',  __eq = '==';
    -- Arithmetic
    __add = '+', __sub = '-', __mul = '*', __div = '/', __pow = '^';
    
    __concat = '..';
    __call = '__call';
    __tostring = 'tostring';
    __gc = 'destroy';
--  this is negation not subtraction, what is the best api for this? 'neg'?
--  __unm = '-'; 
  }

  local class_object = class_object or {}
  
  function class_object.is_domain_of(instance)
      return class_object == getmetatable(instance).class
  end

  function class_object.is_subclass_of(class)
    return class == table
  end

  -- Building constructor
  local constructor = function(self, attrs)
    for attr, value in attrs do self[attr] = value end
  end
  
  if 'function' == type(class_object[1]) then
    constructor = class_object[1]
    class_object.initialize = constructor
  elseif class_object.initalize then
    constructor = class_object.initialize
  end

  local instance_protocol = { class = class_object }
  
  -- Rewrite operator overload events
  table.foreach(events_map, function(event, method)
    if 'function' == type(class_object[method]) then
      instance_protocol[event] = class_object[method]
    end
  end)

  -- Instantiation
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

-- vim:set ts=2 sw=2 sts=2 et:
