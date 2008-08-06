require 'test'
require 'darl/class'

person = class()
a_person = person()

test.assert_true(person.is_domain_of(a_person))
test.assert_false(class().is_domain_of(a_person))

test.assert_true(person.is_subclass_of(table))

-- vim:set ts=4 sw=4 sts=4 et:
