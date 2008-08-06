-- Implementation of a class
-- Using lua metatable
-- 
function class(ParentClass)
    local class_object = {}

    function class_object.is_domain_of(instance)
        return class_object == getmetatable(instance).class
    end

		function class_object.is_subclass_of(class)
			return class == table
		end

		-- Metatable definition for a class to observe events
    local class_protocol = {
        __call = function()
            local instance = {}
            local instance_protocol = {
                class = class_object
            }
            setmetatable(instance, instance_protocol)
            return instance
        end
    }


    setmetatable(class_object, class_protocol)
    return class_object
end

-- vim:set ts=4 sw=4 sts=4 et:
