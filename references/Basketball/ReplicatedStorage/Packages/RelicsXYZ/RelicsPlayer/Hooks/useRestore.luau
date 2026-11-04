 
 

local Shared = script:FindFirstAncestor("RelicsXYZ").Shared;
local React = require(Shared.React);
require(Shared.Signal);
local RunContext = require(Shared.RunContext);
local TeleportService = game:GetService("TeleportService");
local useChanged = require(script.Parent.useChanged);
local u1;

if RunContext.IsEdit then
    u1 = shared.RelicsXYZ;
else
    u1 = setmetatable({}, {
        __index = function(p2: string) -- Line: 15, Name: __index
            -- upvalues: TeleportService (copy)
            return TeleportService:GetTeleportSetting((`RELICSxyz_{p2}`));
        end,

        __newindex = function(p3: string, p4: any) -- Line: 19, Name: __newindex
            -- upvalues: TeleportService (copy)
            TeleportService:SetTeleportSetting(`RELICSxyz_{p3}`, p4);
        end
    });
end;

if not u1 and RunContext.IsEdit then
    u1 = {};
    shared.RelicsXYZ = u1;
end;

return function(u5: string, p6: any, p7: any) -- Line: 31, Name: useRestore
    -- upvalues: u1 (ref), useChanged (copy), React (copy)
    if u1[u5] ~= nil then
        p6 = u1[u5];
    end;

    local u8, v9;

    if p7 then
        u8, v9 = useChanged(p6, p7);
    else
        u8, v9 = React.useState(p6);
    end;

    React.useEffect(function() -- Line: 44
        -- upvalues: u1 (ref), u5 (copy), u8 (ref)
        u1[u5] = u8;
    end, { u8 });

    return u8, v9;
end;