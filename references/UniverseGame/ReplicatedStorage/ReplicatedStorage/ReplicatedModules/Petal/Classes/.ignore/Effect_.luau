  

 

local u1 = {};

for _, child in pairs(script:GetChildren()) do
    u1[child.Name] = require(child);
end;

local function GetVariant(p2) -- Line: 12
    -- upvalues: u1 (copy)
    if u1[p2] ~= nil then
        return u1[p2];
    end;
end;

return function(u3) -- Line: 18
    -- upvalues: u1 (copy)
    local u4 = u3("Util");
    local u5 = {};
    u5.__index = u5;

    function u5.new() -- Line: 24
        -- upvalues: u5 (copy)
        return setmetatable({
            _prefab = nil
        }, u5);
    end;

    function u5.Use(p6, p7) -- Line: 30
        if p7 ~= nil and (p7.Type ~= nil and p7.Type == "EffectPrefab") then
            p6._prefab = p7._internal;
        end;

        return p6;
    end;

    function u5.Render(p8, p9) -- Line: 38
        -- upvalues: u4 (copy), u1 (ref), u3 (copy)
        if p8._prefab ~= nil then
            local Variant = p8._prefab.Variant;
            local u10;

            if p9 then
                u10 = u4.tableMerge(p8._prefab, p9);
            else
                u10 = p8._prefab;
            end;

            local v11;

            if u1[Variant] == nil then
                v11 = nil;
            else
                v11 = u1[Variant];
            end;

            local u12 = v11(u3, u10).new();
            local u13 = nil;
            coroutine.resume(coroutine.create(function() -- Line: 51
                -- upvalues: u13 (ref), u12 (copy), u10 (ref)
                repeat
                    game:GetService("RunService").Heartbeat:Wait();
                    u13 = u12:Update();
                until u13 >= u10.Duration;
            end));

            return u12;
        end;

        local v14 = p9.Variant or "Variant";
        local v15;

        if u1[v14] == nil then
            v15 = nil;
        else
            v15 = u1[v14];
        end;

        v15(u3, p9).new();
    end;

    return u5;
end;