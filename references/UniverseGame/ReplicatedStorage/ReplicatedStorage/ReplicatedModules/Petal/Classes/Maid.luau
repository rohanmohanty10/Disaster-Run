  

 

return function(p1) -- Line: 6
    local u2 = {};

    function u2.new() -- Line: 9
        -- upvalues: u2 (copy)
        return setmetatable({
            _Tasks = {}
        }, u2);
    end;

    function u2.giveTask(p3, p4) -- Line: 14
        local v5 = #p3._Tasks + 1;
        p3._Tasks[v5] = p4;

        return v5;
    end;

    function u2.Clean(p6) -- Line: 20
        local _Tasks = p6._Tasks;

        for i, v in next, _Tasks do
            local v7 = typeof(v);
            local v8 = v7 == "table";

            if v7 == "RBXScriptConnection" or v8 and v.Disconnect then
                v:Disconnect();
            elseif v7 == "Instance" or v8 and v.Destroy then
                v:Destroy();
            else
                v();
            end;

            _Tasks[i] = nil;
        end;
    end;

    function u2.Link(u9, p10, p11, p12) -- Line: 36
        local v13 = p11 or "Destroying";
        local v14 = typeof(p10) == "Instance";
        assert(v14);

        if p12 == nil then
            local _ = u9 + p10[v13]:Connect(function() -- Line: 41
                -- upvalues: u9 (ref)
                u9:Clean();
            end);
        else
            u9 = u9 + p10[v13](p10, p12):Connect(function() -- Line: 45
                -- upvalues: u9 (ref)
                u9:Clean();
            end);
        end;
    end;

    u2.Disconnect = u2.Clean;
    u2.Destroy = u2.Clean;
    u2.GiveTask = u2.giveTask;

    function u2.__index(p15, p16) -- Line: 55
        -- upvalues: u2 (copy)
        return u2[p16] or p15._Tasks[p16];
    end;

    function u2.__add(p17, p18) -- Line: 59
        p17:giveTask(p18);

        return p17;
    end;

    function u2.__concat(p19, p20) -- Line: 64
        if typeof(p20) == "Instance" then
            p19:Link(p20);

            return p19;
        end;

        if typeof(p20) == "table" then
            local v21, v22, v23 = unpack(p20);
            local v24 = typeof(v22) == "string" and true or v22 == nil;
            assert(v24, "Method needs to be a string");
            p19:Link(v21, v22, v23);
        end;

        return p19;
    end;

    function u2.__newindex(p25, p26, p27) -- Line: 75
        local _Tasks = p25._Tasks;
        local v28 = _Tasks[p26];

        if v28 or p27 == nil then
            local v29 = typeof(v28);
            local v30 = v29 == "table";

            if v29 == "RBXScriptConnection" or v30 and v28.Disconnect then
                v28:Disconnect();
            elseif v29 == "Instance" or v30 and v28.Destroy then
                v28:Destroy();
            end;
        end;

        _Tasks[p26] = p27;
    end;

    return u2;
end;