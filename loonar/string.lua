
-- Extend native type String

string_protocol = getmetatable("")

-- function string_protocol.__index(self, method)
-- 
--   if 'length' == method then
--     return string.len(self)
--     
--   elseif 'lower' == method then
--     return string.lower(self)
--     
--   elseif 'upper' == method then
--     return string.upper(self)
--     
--   elseif 'capitalize' == method then
--     return string.upper(string.sub(self,1,1))..string.sub(self, 2)
-- 
--   end
--   return self
-- end
-- 
-- 
-- test.assert_equals(4, ("test").length)
-- test.assert_equals("TEST", ("test").upper)
-- test.assert_equals("test", ("TEST").lower)
-- test.assert_equals('Test', ("test").capitalize)
