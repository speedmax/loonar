
Person = class {
	function(name, age)
		self.name = name
		self.age = age
	end,
	
	destory = function() end
}

a_person = Person('Taylor luk', 26)

--test.assert_equals('Taylor luk', a_person.name)
--test.assert_equals(26, a_person.age)

test.assert_true(Person.is_domain_of(a_person))
test.assert_false(class().is_domain_of(a_person))

test.assert_true(Person.is_subclass_of(table))

-- vim:set ts=4 sw=4 sts=4 et:
