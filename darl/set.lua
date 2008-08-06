-- Set class
-- For array or hash like object 
-- to provide enumerable traversal and searching methods

function Set(object)
	local instance = {}
	local class = {}
	
	-- overload array methods by observing events
	metatble = {
		each= function(iteratable)
			table.foreach(object, iteratable)
		end,
		-- Overload array getter
		__index = function(table, key) 
			return table[key]
		end,
		
		-- Overload Array setter
		__newindex = function(table, key, value) end, 
		
		-- Array concat
		__add = function(a, b)	end,
		__concat = __add,
		
		-- Array Diff 
		__sub = function(a, b) end,
		
		-- Array join or multipy value?
		--  join : {1,2} * '/' = '1/2'
		--  multi : {1,2} * 2 = {2,4} or {1,1,2,2}
		__mul = function(a, b) end,
		
		-- Array split 
		--   split : 
		__div = function() end,
		
		-- Overload more instance methods?
		__call = function(t, k, v)
			print(t, k, v)
		end,
		__toString = function(table, key, value) end
	}
	
	setmetatable(object, metatable)
	
	-- Class methods, ?? is this the right way ??
	-- function class:new(object)	
	-- 		object = object or {}
	-- 		setmetatable(object, class)
	-- 		return object
	-- 	end
	-- 	
	function each(object, iterator)
		-- table.forEach(self, iterator)
		print 'not implemented'
	end
	
	function class.map() end
	function class.reduce() end
	function class.collect() end
	function class.detect() end
	function class.select() end
	
	function class.inject() end
	function class.reject() end
	
	function class.filter() end
	function class.any() end
	function class.all() end
	return (object)
end