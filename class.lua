require 'loonar.class'

do -- test table.merge
  local merged = table.merge(
    { a = 1, b = 2, c = 3 },
    { b = 4, d = 5 },
    { e = 6 }
  )

  test.assert_equals(1, merged.a)
  test.assert_equals(4, merged.b)
  test.assert_equals(3, merged.c)
  test.assert_equals(5, merged.d)
  test.assert_equals(6, merged.e)
end

do -- test isa relationship
  local foo = class {}

  test.assert(foo.is_domain_of(foo()))
  test.assert(class.is_domain_of(foo))
end

do -- test constructor
  local foo = class {
    function(self, ...)
      self.first, self.second = ...
      print 'here'
    end
  }

  local i = foo(1, 2)

  test.assert_equals(1, i.first)
  test.assert_equals(2, i.second)

  test.assert_nil(foo.prototype[1])
end

do -- test default constructor
  local foo = class {}
  local i = foo { first = 1, second = 2 }

  test.assert_equals(1, i.first)
  test.assert_equals(2, i.second)
end


do -- test inhieritance
  local mammal = class {
    function(self, name)
      self.name = name
      self.body_features = {'hair', 'heart', 'teeth'}
    end;
    
    talk = function(self)
      print 'i am a mammal'
    end;
  }
  
  local pet = mammal.subclass {
    function(self, ...)
      self.name, self.owner = ...
      self.super(self.name)
    end;
    
    eat = function(self) 
      print 'feeting the pet' 
    end;
  }

  local mydog = pet('bobo', 'taylor luk')

  print(mydog.body_features)
  mydog.eat()
end