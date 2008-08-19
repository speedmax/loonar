function table.merge(...)
  params = {...}
  result = {}

  for i = 1, #params do
    for key, value in pairs(params[i]) do
      result[key] = value
    end
  end

  return result
end

class = {}

class['@instance_protocol'] = {
  __index = function(instance, member)
    if rawget(instance, member) then
      return rawget(instance, member)
    end

    local mt = getmetatable(instance)
    if mt then
      local class, superclass = mt.class, mt.superclass
      if class and class.prototype and class.prototype[member] then
        -- TODO: Implement bounded_method class.
        if type(class.prototype[member]) == 'function' then
          return function(...)
            return class.prototype[member](instance, ...)
          end
        else
          return class.prototype[member]
        end
        
      -- need refactor
      elseif superclass and superclass.prototype and superclass.prototype[member] then
        if type(clsuperclassass.prototype[member]) == 'function' then
          return function(...)
            return superclass.prototype[member](instance, ...)
          end
        else
          return superclass.prototype[member]
        end
      end
    end
  end
}

class['@protocol'] = {
  class = class,
  __call = function(class_obj, ...)
    local instance = {}

    local instance_protocol = table.merge(
      class['@instance_protocol'],
      { class = class_obj }
    )

    setmetatable(instance, instance_protocol)

    class_obj.constructor(instance, ...)

    return instance
  end,
  __index = class['@instance_protocol'].__index
}

function class:constructor(prototype)
  self.prototype = prototype

  if self.prototype[1] then
    self.constructor = self.prototype[1]
    self.prototype[1] = nil
  else
    function self.constructor(instance, members)
      if type(members) == 'table' then
        for name, value in pairs(members) do
          instance[name] = value
        end
      end
    end
  end

  setmetatable(self, table.merge(
    getmetatable(self), class['@protocol']
  ))

  return true
end

class.prototype = {
  is_domain_of = function(self, instance)
      local metatable = getmetatable(instance)
      if metatable then
        return metatable.class == self
      else
        return false
      end
  end;
  
  subclass = function(superclass, prototype)
    -- Missing constructor 
    if not (prototype[1] and type(prototype[1]) == 'function') then
      prototype[1] = superclass.constructor
    end
    
    local classobj = class(prototype)
    
    -- set superclass on classobj metatable, what about instance metatable
    local protocol = table.merge(
      getmetatable(classobj), { superclass = superclass }
    )
    setmetatable(classobj, protocol)
    
    classobj.prototype.super = superclass.constructor

    inspect(getmetatable(classobj))

    return classobj
  end;
}

setmetatable(class, class['@protocol'])
