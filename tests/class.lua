require 'test'

function class()
    local class_object = {}

    class_object.is_class_of = function(instance)
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

person = class()
a_person = person()

test.assert_true(person.is_class_of(a_person))
test.assert_false(class().is_class_of(a_person))
