  

function observeChildren(u1: userdata, u2: function)
    local u3 = {};
    local u4 = nil;

    local function OnInstanceAdded(p5: userdata) -- Line: 19
        -- upvalues: u4 (ref), u3 (copy), u2 (copy)
        if not u4.Connected or u3[p5] then
            return;
        end;

        u3[p5] = true;
        u3[p5] = u2(p5);
    end;

    u4 = u1.ChildAdded:Connect(OnInstanceAdded);
    local u8 = u1.ChildRemoved:Connect(function(p6: userdata) -- Line: 10, Name: OnInstanceRemoved
        -- upvalues: u3 (copy)
        local v7 = u3[p6];
        u3[p6] = nil;

        if typeof(v7) == "function" then
            task.spawn(v7);
        end;
    end);
    task.defer(function() -- Line: 34
        -- upvalues: u4 (ref), u1 (copy), OnInstanceAdded (copy)
        if not u4.Connected then
            return;
        end;

        for _, child in u1:GetChildren() do
            task.spawn(OnInstanceAdded, child);
        end;
    end);

    return function() -- Line: 45
        -- upvalues: u4 (ref), u8 (ref), u3 (copy)
        u4:Disconnect();
        u8:Disconnect();
        local v9 = next(u3);

        while v9 do
            local v10 = u3[v9];
            u3[v9] = nil;

            if typeof(v10) == "function" then
                task.spawn(v10);
            end;

            v9 = next(u3);
        end;
    end;
end;

return observeChildren;