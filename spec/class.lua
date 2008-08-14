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

describe('class - simple class foo') {
  before = function(self)
    self.f = foo { name = 'foo'; bar = true; }
  end;
  
  ["builds default constructor for class foo"] = function(self)
    type_of(
      getmetatable(self.f).class.initialize
    ).should_be 'function'
  end;
  
  ["should be instance of foo, class"] = function(self)
    expect(foo.is_domain_of(self.f)).should_be_true()
    expect(class().is_domain_of(self.f)).should_be_false()
  end;
  
  ["shuold be subclass of table"] = function(self)
    expect(foo.is_subclass_of(table)).should_be_true()
  end;
  
  ["property and method access"] = function(self)
    local f= self.f
    expect(f.self()).should_be(f)
    
    expect(f.name).should_be 'foo'
    expect(tostring(f)).should_be 'foo'
    
    expect(f.bar).should_be_true()
  end;
  
  ["overloads operators, setter and getters"] = function(self)
    local f = self.f
    expect( f + 123 ).should_be '+ 123'
    
    expect( f[123] ).should_be(123)
    
    expect( f[f] ).should_be(f)
    expect( f.abc ).should_be 'abc'
    
    expect(tostring(f)).should_be(f.name)
  end
}

-- person Class Example

person = class {
  function(self, name, age)
    self.name = name
    self.age = age
  end;
  
  destory = function(self) end;
}

describe('class - person class') 
{
  ['constructor should set person property'] = function(self)
    p1 = person('Taylor luk', 26)

    expect( p1.name ).should_be 'Taylor luk'
    expect( p1.age ).should_be(26)
  end;
}

-- complex class example

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

describe ('class - complex class') 
{
  before = function(self)
    self.c1, self.c2 = complex(1,2), complex(2,5)
  end;
  
  ["overloads arithmetic operations"] = function(self)
    local c1, c2 = self.c1, self.c2
    
    expect( (c1 + c2).real ).should_be(3)
    expect( (c1 - c2).imaginary ).should_be(-3)
    expect(c1 + c2).should_be(complex(3, 7))
  end;
  
  ["should be comparible against each other"] = function(self)
    local c1, c2 = self.c1, self.c2
    
    expect(c1 == c1).should_be_true()
    expect(c2 == c2).should_be_true()
    expect(c1 == c2).should_be_false()
  end;
}
