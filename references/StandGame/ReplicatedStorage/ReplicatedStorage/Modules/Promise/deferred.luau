 

 

return function(u1, ...) --[[ Line: 1 ]]
    local v2 = type(u1) == "function";
    assert(v2);
    local u3 = table.pack(...);
    local u4 = Instance.new("BindableEvent");
    u4.Event:Connect(function() --[[ Line: 7 ]]
        -- upvalues: u4 (copy), u1 (copy), u3 (copy)
        u4:Destroy();
        u1(table.unpack(u3));
    end);
    u4:Fire();
end;