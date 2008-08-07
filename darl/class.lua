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
            local instance_protocol = {
                class = class_object
            }
            local constructor = instance[1] or nil

            setmetatable(instance, instance_protocol)

            if (constructor) then
                self = instance
                constructor(...)
            end
            return instance
        end
    }
    
    class_protocol = table.merge(class_protocol, overload)
    
    setmetatable(class_object, class_protocol)

    return class_object
end

-- vim:set ts=4 sw=4 sts=4 et:
