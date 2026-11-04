  

local v1 = {};
local RunService = game:GetService("RunService");
local script_Parent = script.Parent;
local React = require(script_Parent.React);
local Ripple = require(script_Parent.Ripple);
v1.config = table.freeze({
    default = table.freeze({
        tension = 170,
        friction = 26
    }),
    gentle = table.freeze({
        tension = 120,
        friction = 14
    }),
    wobbly = table.freeze({
        tension = 180,
        friction = 12
    }),
    stiff = table.freeze({
        tension = 210,
        friction = 20
    }),
    slow = table.freeze({
        tension = 280,
        friction = 60
    }),
    molasses = table.freeze({
        tension = 280,
        friction = 120
    })
});

function v1.useSpring(p2: table) -- Line: 65
    -- upvalues: React (copy), Ripple (copy), RunService (copy)
    local table_clone_ret = table.clone(p2);
    local config = table_clone_ret.config;
    local from = table_clone_ret.from;
    local to = table_clone_ret.to;
    table_clone_ret.config = nil;
    table_clone_ret.from = nil;
    table_clone_ret.to = nil;
    local u3 = React.useState({});
    local v4 = {};
    local v5 = {};

    if from then
        for i, v in from do
            v4[i] = v;
        end;
    end;

    for i, v in table_clone_ret do
        v4[i] = v;
        v5[i] = v;
    end;

    if to then
        for i, v in to do
            if v4[i] == nil then
                v4[i] = v;
            end;

            v5[i] = v;
        end;
    end;

    for i, v in v4 do
        if not u3[i] then
            local v6, v7 = React.createBinding(v);
            u3[i] = {
                SetValue = v7,
                Binding = v6,
                Motion = Ripple.createMotion(v),
                Target = v
            };
        end;
    end;

    local v8 = {};

    for i, v in v5 do
        local v9 = u3[i];

        if v9 then
            v9.Target = v;
        end;

        v8[i] = v9.Binding;
    end;

    React.useEffect(function() -- Line: 146
        -- upvalues: RunService (ref), u3 (copy), config (copy)
        local u12 = RunService.Heartbeat:Connect(function(p10: number) -- Line: 147
            -- upvalues: u3 (ref), config (ref)
            for _, v in u3 do
                local Motion = v.Motion;
                local Binding = v.Binding;
                Motion:spring(v.Target, config);
                local v11 = Motion:step(p10 / 2);

                if v11 ~= Binding:getValue() then
                    v.SetValue(v11);
                end;
            end;
        end);

        return function() -- Line: 164
            -- upvalues: u12 (copy)
            u12:Disconnect();
        end;
    end);

    return v8;
end;

return v1;