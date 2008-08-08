
person = class {
  function(self, name, age)
    self.name = name
    self.age = age
  end;

  destory = function(self) end;
}

p1 = person('Taylor luk', 26)

-- Object relationship
test.assert_true(person.is_domain_of(p1))
test.assert_false(class().is_domain_of(p1))
test.assert_true(person.is_subclass_of(table))

-- Object creation and property access
test.assert_equals('Taylor luk', p1.name)
test.assert_equals(26, p1.age)

complex = class {
  function(self, real, imaginary)
    self.real, self.imaginary = real, imaginary
  end;

  ['+'] = function(self, operand)
    return complex(
      self.real + operand.real,
      self.imaginary + operand.imaginary
    )
  end;

  ['-'] = function(self, operand)
    return complex(
      self.real - operand.real,
      self.imaginary - operand.imaginary
    )
  end;

  tostring = function(self)
    return '(' .. self.real .. '+' .. self.imaginary .. 'i)'
  end;
}

c1 = complex(1, 2)
c2 = complex(2, 5)

test.assert_true(complex.is_domain_of(c1))

added = c1 + c2
test.assert_equals(3, added.real)
test.assert_equals(7, added.imaginary)

subtracted = c1 - c2
test.assert_equals(-1, subtracted.real)
test.assert_equals(-3, subtracted.imaginary)

-- vim:set ts=2 sw=2 sts=2 et:
