
function class()
    local class_object = {}

    function class_object.is_domain_of(instance)
        return class_object == getmetatable(instance).class
    end

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
