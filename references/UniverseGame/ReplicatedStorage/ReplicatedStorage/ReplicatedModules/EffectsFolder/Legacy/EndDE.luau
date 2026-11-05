  

 

local u1 = {};

return function() -- Line: 3
    -- upvalues: u1 (copy)
    if u1.DEData == nil then
        warn("No data!");

        return;
    end;

    u1.DEData.Cleanup();
    u1.DEData = nil;
end;