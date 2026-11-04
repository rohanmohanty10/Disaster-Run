 

 

return function() -- Line: 6
    local u1 = {};

    return function(p2) -- Line: 9
        -- upvalues: u1 (copy)
        table.insert(u1, p2);

        return p2;
    end, function() -- Line: 14
        -- upvalues: u1 (copy)
        for _, v in u1 do
            if typeof(v) == "Instance" then
                v:Destroy();
            elseif typeof(v) == "RBXScriptConnection" then
                v:Disconnect();
            elseif typeof(v) == "function" then
                task.spawn(v);
            elseif typeof(v) == "thread" then
                pcall(task.cancel, v);
            elseif typeof(v) == "table" and (v._binCleanup and type(v._binCleanup) == "function") then
                v:_binCleanup();
            end;
        end;

        table.clear(u1);
    end;
end;