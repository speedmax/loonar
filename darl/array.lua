-- Set class
-- For array or hash like object 
-- to provide enumerable traversal and searching methods
Array = class {
  
    function(data)
        self.data = data
    end, 
    
		each = function(func)
			for k,v in pairs(self.data) do 
				func(v, k) 
			end
		end,

    print = function ()
        table.foreach(self.data, print)
    end,
    
		overload = {
        __index = function(table, key)
						return self.data[key]
        end
		}
}
a = Array
