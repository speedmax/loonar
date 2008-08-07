-- Implementation of a class
-- Using lua metatable
-- 
function class(class_object)
    local class_object = class_object or {}
    local overload = class_object.overload or {}

    function class_object.is_domain_of(instance)
        return class_object == getmetatable(instance).class
    end

	function class_object.is_subclass_of(class)
		return class == table
	end
	
    -- Metatable definition for a class to observe events
    local class_protocol = {
        __call = function(instance, ...)
            local instance = instance or {}
						local constructor = nil
						
						if (type(instance[1]) == 'function') then
							constructor = table.remove(instance, 1)
						elseif instance.initalize then
							constructor = instance.initialize
						end
						
						local instance_protocol = table.merge({
                class = class_object
            }, overload)

            setmetatable(instance, instance_protocol)

            if (constructor) then
								class_object.initalize = constructor
                self = instance
                constructor(...)
            end
            return instance
        end
    }
    
    
    setmetatable(class_object, class_protocol)

    return class_object
end

-- vim:set ts=4 sw=4 sts=4 et:
