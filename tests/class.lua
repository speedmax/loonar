-- Class Example
foo = class {
  self = function(self)
    return self
  end;

  ['+'] = function(self, operand)
    return '+ ' .. tostring(operand)
  end;

  ['.'] = function(self, key)
    return key
  end;

  tostring = function(self)
    return self.name
  end;
}


  -- using default constructor
  f = foo { name = 'foo'; bar = true; tostring = 'string'; }

  -- Object relationship
  test.assert_true(foo.is_domain_of(f))
  test.assert_false(class().is_domain_of(f))
  test.assert_true(foo.is_subclass_of(table))
  test.assert_false(foo.is_domain_of(1))

  -- index
  test.assert_equals(f, f.self())
  test.assert_equals('foo', f.name)
  test.assert_equals('string', f.tostring)
  test.assert_true(f.bar)

  -- Operator Overloading
  test.assert_equals('+ 123', f + 123)
  test.assert_equals(123, f[123])
  test.assert_equals(f, f[f])
  test.assert_equals('abc', f.abc)

  -- Magic Method
  test.assert_equals(f.name, tostring(f))


-- person Class Example

person = class {
  function(self, name, age)
    self.name = name
    self.age = age
  end;
  
  destory = function(self) end;
}

  p1 = person('Taylor luk', 26)

  -- Object creation and property access
  test.assert_equals('Taylor luk', p1.name)
  test.assert_equals(26, p1.age)


-- complex Number Example

complex = class {
  initialize = function(self, real, imaginary)
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

  ['=='] = function(self, operand)
    return self.real == operand.real and self.imaginary == operand.imaginary
  end;

  tostring = function(self)
    return '(' .. self.real .. '+' .. self.imaginary .. 'i)'
  end;
}



  c1 = complex(1, 2)
  c2 = complex(2, 5)

  test.assert_equals(3, (c1 + c2).real)
  test.assert_equals(-3, (c1 - c2).imaginary)

  test.assert_true(c1 == c1)
  test.assert_true(c2 == c2)

  test.assert_equals(complex(3, 7), c1 + c2)

-- vim:set ts=4 sw=4 sts=4 et:
