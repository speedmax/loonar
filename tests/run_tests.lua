require 'test'
require 'class'

for i = 1, #test.fails do
    local fail = test.fails[i]
    print(i .. ". " .. fail.message)
    print(fail.trace)
end

/* vim:set ts=4 sw=4 sts=4 et: */
