--[[
  class spec
]]

-- Simple foo class
local foo = class {
  self = function(self) return self end;

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

-- person class
local person = class {
  function(self, name, age, location)
    self.name, self.age  = name, age
    self.location = location
  end;

  geolocation = function(self)
    return self.location
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

describe "class - constructor"
{ 
  before = function(self) 
    self.f = foo { name = 'foo'; bar = true; }
  end;
  
  ['should accept argument and set object property'] = function(self)
    p1 = person('Taylor luk', 26)
    
    expect( p1.name ).should_be 'Taylor luk'
    expect( p1.age ).should_be(26)
  end;

  ["builds instance of a class "] = function(self)
    expect(foo.is_domain_of(self.f)).should_be_true()
    expect(class().is_domain_of(self.f)).should_be_false()
  end;
  
  
  ["where class should be subclass of table"] = function(self)
    expect(foo.is_subclass_of(table)).should_be_true()
  end;
  
  ["builds default constructor for method-less class "] = function(self)
    local result = getmetatable(self.f).class.initialize
    
    type_of(result).should_be 'function'
  end;

}

describe "class - property and method access"
{ 
  before = function(self)
    self.f = foo { name = 'foo'; bar = true; }
    self.p = person ('taylor luk', 26, 'Sydney Australia')
  end;

  ["allows property access"] = function(self)
    local f = self.f
    expect(f.name).should_be 'foo'
    expect(f.bar).should_be_true()
  end;

  ["should allow instance method access"] = function(self)
    local f, p = self.f, self.p
    expect(f.self()).should_be(f)
    expect(p.geolocation()).should_be 'Sydney Australia'
  end;

  ["generic methods available for both instance, class context"] = function(self)
    expect(self.p.geolocation()).should_be 'Sydney Australia'
    
    local p2 = person('minhee', 999, 'Korea, Planet Earth')
    expect(person.geolocation(p2)).should_be 'Korea, Planet Earth'
  end;
}

describe "class - property and operator overload"
{ 
  before = function(self)
    self.c1, self.c2 = complex(1,2), complex(2,5)
    self.f = foo { name = 'foo'; bar = true; }
  end;
  
  ["overloads operators, setter and getters"] = function(self)
    local f = self.f
    
    expect( f + 123 ).should_be '+ 123'
    expect( f[123] ).should_be(123)
    
    expect( f[f] ).should_be(f)
    expect( f.abc ).should_be 'abc'    
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

  ["overloads tostring should return string representation"] = function(self)
    expect(tostring(self.f)).should_be(self.f.name)
    expect(tostring(self.f)).should_be 'foo'
  end;

}
