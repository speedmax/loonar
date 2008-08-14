describe "array - standard access"
{
  before = function(self)
    self.list = a{888, 999, 566, 444, 112}
  end;
  
  ["sets item value by idex"] = function(self)
    self.list[2] = 22
    expect(self.list[2]).should_be(22)
    expect(self.list[2]).should_not_be(999)
  end;
  
  ["gets item by index"] = function(self) 
    expect(self.list[1]).should_be(888)
    expect(self.list[5]).should_be(112)
  end;
  
  ["array.first should return the first element"] = function(self)
    expect(self.list.first).should_be(self.list[1])
  end;
  
  ["array.last should return the last element"] = function(self)
    expect(self.list.last).should_be(self.list[#self.list])
  end;
}

describe "array - iterator"
{
  before = function(self)
    self.list = a{1,2,3,4,5} 
  end;
  
  ["array#each should iterate through all elements"] = function(self)
    local sum = 0
    local list = a{1,2,3,4,5}
    list.each(function(value) sum = sum + value end)
    expect(sum).should_be(1+2+3+4+5)
  end;
}

describe "array - transformation iterator"
{
  before = function(self)
    self.list = a{111,222,333,444}
  end;
  
  ["array#map should return transformed array"] = function(self)
  
    local result = self.list.map(function(value, key) 
      return value + 1
    end)
    
    type_of(result).should_be 'table'
    expect(result).should_be(a{112,223,334,445})
    expect(self.list).should_be(a{111,222,333,444})
  end;
  
  ["array#reduce reduces reduces to singular value"] = function(self)
    local result = self.list.reduce(0, function(sum, value) 
      return sum + value
    end)
  
    type_of(result).should_be "number"
    expect(result).should_be(111 + 222 + 333 + 444)
  end;
}

describe "array - conditional iterator"
{
  before = function(self)
    self.list = a{111,222,333,444}
  end;
  
  ["array#any requires condition met with any item"] = function(self)
    local r1 = self.list.any(function(e) return e > 400 end)
    local r2 = self.list.any(function(e) return e > 500 end)
    
    expect(r1).should_be_true()
    expect(r2).should_be_false()
  end;
  
  ["array#all requires condition met with all items"] = function(self)
    local r1 = self.list.all(function(e) return e > 1 end)
    local r2 = self.list.all(function(e) return e > 200 end)

    expect(r1).should_be_true()
    expect(r2).should_be_false()
  end;
  
  ["array#contains require if element exists"] = function(self)
    expect(self.list.contains(333)).should_be_true()  
    expect(self.list.contains(3)).should_be_false()
  end;
  
  ["array#filter should return all elements met given condition"] = function(self)
    local result = self.list.filter(function(e) return e > 300 end)  
  
    expect(result).should_be(a{333,444})
    expect(result == a{}).should_be_false()
  end;
}

describe "array - utilities"
{
  ["array#merge"] = function(self)
    expect(a{1, 2}.merge(a{3, 4})).should_be(a{1, 2, 3, 4})
  end;

  ["array#flatten should flatten a multidimensional array into a single array"] = function(self)
    local array = a{
      1, 2, 3, 4, a{a{5}, 6, 7, 8, a{9, 10, a{11}, 12, 13}, 14, a{15, 16}},
      17, 18, a{a{a{a{a{a{19}}}}}}, 20, 21, a{22, a{23, a{24, a{25}}}}
    }
    expect(array.flatten()).should_be(a{
       1,  2,  3,  4,  5,
       6,  7,  8,  9, 10,
      11, 12, 13, 14, 15,
      16, 17, 18, 19, 20,
      21, 22, 23, 24, 25
    })
  end;
}
