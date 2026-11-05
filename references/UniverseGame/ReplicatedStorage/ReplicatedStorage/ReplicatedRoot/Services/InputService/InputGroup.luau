  

 

local Core = require(game.ReplicatedStorage.ReplicatedRoot.Core);
require(Core.ReplicatedLibraries.Utility.TableUtil);
local u1 = {};
u1.__index = u1;

function u1.new(p2) -- Line: 21
    -- upvalues: u1 (copy)
    local v3 = setmetatable({}, u1);
    v3.Name = p2 or "InputGroup";
    v3.Inputs = {};

    return v3;
end;

function u1.AddInputs(p4, p5) -- Line: 30
    for i, v in pairs(p5) do
        p4:AddInput(i, v);
    end;
end;

function u1.AddInput(p6, p7, p8) -- Line: 36
    p6.Inputs[p7] = {
        Active = false,
        Name = p7,
        Binds = p8 or {}
    };
end;

function u1.RemoveInput(p9, p10) -- Line: 45
    p9.Inputs[p10] = nil;
end;

function u1.GetInput(p11, p12) -- Line: 49
    return p11.Inputs[p12];
end;

function u1.BindInput(p13, p14, p15) -- Line: 53
    local v16 = p13:GetInput(p14);

    if v16 ~= nil and not table.find(v16.Binds, p15) then
        table.insert(v16.Binds, p15);
    end;
end;

function u1.UnbindInput(p17, p18, p19) -- Line: 62
    local v20 = p17:GetInput(p18);

    if v20 ~= nil then
        local v21 = table.find(v20.Binds, p19);

        if v21 ~= nil then
            table.remove(v20.Binds, v21);
        end;
    end;
end;

function u1.ClearInput(p22, p23) -- Line: 72
    local v24 = p22:GetInput(p23);

    if v24 ~= nil then
        table.clear(v24.Binds);
    end;
end;

function u1.IsInputActive(p25, p26) -- Line: 79
    local v27 = p25:GetInput(p26);

    if v27 == nil then
        return false;
    end;

    return v27.Active;
end;

function u1.GetActiveInputs(p28) -- Line: 87
    local v29 = {};

    for i, v in pairs(p28.Inputs) do
        if v.Active then
            v29[i] = v;
        end;
    end;

    return v29;
end;

function u1.Destroy(p30) -- Line: 97
    if table.isfrozen(p30) then
        return;
    end;

    table.clear(p30);
    table.freeze(p30);
end;

return u1;