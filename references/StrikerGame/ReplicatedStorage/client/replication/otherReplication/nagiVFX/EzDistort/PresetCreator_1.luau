 
 

require(script.Parent.SharedTypes);
local Paramarizer = require(script.Parent.Paramarizer);
local u1 = {};
local u2 = {};
u2.__index = u2;

function u1.newDistortionPresetParams(p3) -- Line: 10
    -- upvalues: Paramarizer (copy)
    return Paramarizer.newDistortionPresetParams(p3);
end;

function u1.new(p4, p5) -- Line: 15
    -- upvalues: u1 (copy), u2 (copy)
    local v6 = {
        DistortionObject = p4,
        DistortionPresetParams = u1.newDistortionPresetParams(p5)
    };
    local u7 = setmetatable(v6, u2);
    u7.Connections = { p4.Signals.Destroying:Once(function() -- Line: 22
            -- upvalues: u7 (copy)
            u7:Destroy();
        end) };
    u7.DistortionPresetParams.OnCreate(p4, u7);

    return u7;
end;

function u2.AddConnection(p8: table, p9: userdata) -- Line: 33
    table.insert(p8.Connections, p9);
end;

function u2.Destroy(p10) -- Line: 38
    for _, v in p10.Connections do
        v:Disconnect();
    end;

    p10.DistortionPresetParams.OnDestroying(p10);
    setmetatable(p10, nil);
    table.clear(p10);
end;

return u1;