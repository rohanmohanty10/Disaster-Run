  

local script_Parent = script.Parent;
local useSignal = require(script_Parent.useSignal);
local useTagged = require(script_Parent.useTagged);
local useAttribute = require(script_Parent.useAttribute);
local Parent = script_Parent.Parent.Parent;
local Shared = Parent.Shared;
local u1 = require(Parent);
local React = require(Shared.React);

return function() -- Line: 13, Name: useAuraData
    -- upvalues: useTagged (copy), React (copy), u1 (copy), useSignal (copy), useAttribute (copy)
    local v2 = useTagged("RelicsAurasMetadata")[1];
    local u3, u4 = React.useState(u1.GetCachedAuraData);
    useSignal(u1.AuraRolled, function(p5) -- Line: 17
        -- upvalues: u3 (copy), u4 (copy)
        local UnlockedAura = p5.UnlockedAura;

        if UnlockedAura then
            local table_clone_ret = table.clone(u3);
            u3.Unlocks[UnlockedAura] = true;
            u4(table_clone_ret);
        end;
    end);
    useSignal(u1.AuraUpdated, function(p6) -- Line: 27
        -- upvalues: u4 (copy)
        u4((table.clone(p6)));
    end);
    useSignal(u1.OnClientEvent, function(p7) -- Line: 32
        -- upvalues: u1 (ref)
        if p7 == "SyncAuraData" then
            u1.GetAuraDataAsync();
        end;
    end);

    return u3, {
        RollsPerDay = useAttribute(v2, "RollsPerDay", tonumber),
        RollGamePass = useAttribute(v2, "RollGamePass", tonumber),
        RollsWithGamePass = useAttribute(v2, "RollsWithGamePass", tonumber)
    };
end;