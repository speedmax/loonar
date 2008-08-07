-- Set class
-- For array or hash like object 
-- to provide enumerable traversal and searching methods
Array = class {
    name = 'Array',
    
    function(data)
        self.data = data
        print('constructor called')
    end, 
    
    print = function ()
        table.foreach(self.data, print)
    end,
    
    overload = {
        __index = function(table, key)
            print(table);
            print('index called')
            --return table[key]
        end
    }
}

list = Array({11,22,33})


-- Index overloading is not working yet
-- print(list[1])