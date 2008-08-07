
Person = class {
	function(name, age)
		self.name = name
		self.age = age
	end,
	
	destory = function() end
}
p1 = Person('Taylor luk', 26)

-- Object relationship
test.assert_true(Person.is_domain_of(p1))
test.assert_false(class().is_domain_of(p1))
test.assert_true(Person.is_subclass_of(table))


-- Object creation and property access
test.assert_true(p1.name == 'Taylor luk')
test.assert_true(p1.age == 26)

-- vim:set ts=4 sw=4 sts=4 et:
