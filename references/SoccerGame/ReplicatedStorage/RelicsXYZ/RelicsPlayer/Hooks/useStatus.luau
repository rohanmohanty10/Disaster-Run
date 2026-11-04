  

local script_Parent = script.Parent;
local Players = game:GetService("Players");
local Parent = script_Parent.Parent;
local Shared = Parent.Parent.Shared;
local React = require(Shared.React);
require(Shared.Promise);
local RunContext = require(Shared.RunContext);
local UserStatus = require(Parent.Enums).UserStatus;
local useBoomboxData = require(script_Parent.useBoomboxData);
local useAttribute = require(script_Parent.useAttribute);
local useOwnership = require(script_Parent.useOwnership);
local useTagged = require(script_Parent.useTagged);

return function() -- Line: 22, Name: useStatus
    -- upvalues: RunContext (copy), UserStatus (copy), useBoomboxData (copy), useOwnership (copy), useTagged (copy), React (copy), Players (copy), useAttribute (copy)
    if RunContext.IsEdit then
        return UserStatus.BoomboxPurchased;
    end;

    local v1 = useBoomboxData();
    local v2 = {};

    if v1 then
        for i, v in v1.OwnershipIds do
            v2[i] = {
                Id = v,
                InfoType = Enum.InfoType.Asset
            };
        end;
    end;

    local v3 = useOwnership(v2);
    local u4 = useTagged("RelicsPlaylist");
    local v5, u6 = React.useState(false);
    React.useEffect(function() -- Line: 43
        -- upvalues: u4 (copy), Players (ref), u6 (copy)
        for _, v in u4 do
            local v7 = v:FindFirstAncestorOfClass("Player");

            if (v7 == Players.LocalPlayer or v7 == nil) and v:GetAttribute("IsFree") then
                u6(true);

                return;
            end;
        end;

        u6(false);
    end, { u4 });
    local LocalPlayer = Players.LocalPlayer;
    local v8, v9 = React.useState(false);
    local v11 = useAttribute(LocalPlayer, "RelicsTrial", function(p10) -- Line: 61
        return p10 and true or false;
    end);

    if v11 and not v8 then
        v9(true);
    end;

    local v13 = useAttribute(LocalPlayer, "RelicsDebugOwned", function(p12) -- Line: 69
        -- upvalues: RunContext (ref)
        if RunContext.IsStudio then
            return p12 and true or false;
        end;

        return false;
    end);
    local Freemium = UserStatus.Freemium;

    if v3 or v13 then
        return UserStatus.BoomboxPurchased;
    end;

    if v11 then
        return UserStatus.TryBeforeBuy;
    end;

    if v8 or not v5 then
        Freemium = UserStatus.TrialExpired;
    end;

    return Freemium;
end;