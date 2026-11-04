 

return function(p1, ...) --[[ Line: 1 ]]
    task.desynchronize()
    p1(...)
    task.synchronize()
end