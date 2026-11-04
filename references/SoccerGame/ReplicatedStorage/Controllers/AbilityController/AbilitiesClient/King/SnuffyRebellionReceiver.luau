  

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local AbilityUtils = require(ReplicatedStorage.Shared.AbilityUtils);
local AbilityBalancing = require(ReplicatedStorage.AbilityBalancing);
local interface = require(ReplicatedStorage.Controllers.AbilityController.interface);
local u1 = false;

return function() -- Line: 8
    -- upvalues: Players (copy), u1 (ref), interface (copy), AbilityUtils (copy), AbilityBalancing (copy)
    local LocalPlayer = Players.LocalPlayer;

    if u1 or LocalPlayer:GetAttribute("CRRequest") ~= "SnuffyRebellion" then
        return false;
    end;

    local Character = LocalPlayer.Character;
    local v2;

    if Character then
        v2 = Character:FindFirstChildOfClass("Humanoid");
    else
        v2 = Character;
    end;

    local v3;

    if Character then
        v3 = Character:FindFirstChild("Values");
    else
        v3 = Character;
    end;

    if not (v2 and (v2.Health > 0 and (v3 and (v3.HasBall.Value and not v3.InCutscene.Value)))) then
        return false;
    end;

    local Attribute = LocalPlayer:GetAttribute("CRRequestToken");
    local Attribute2 = LocalPlayer:GetAttribute("CRSender");

    if typeof(Attribute) ~= "string" or typeof(Attribute2) ~= "number" then
        return false;
    end;

    u1 = true;
    local success, result = pcall(function() -- Line: 19
        -- upvalues: interface (ref), Attribute (copy), Attribute2 (copy)
        return interface.AbilityService:TryServerArmedChemicalReaction("SnuffyRebellion", {
            Token = Attribute,
            SenderUserId = Attribute2
        });
    end);
    u1 = false;

    if not (success and (result == true and (LocalPlayer.Character == Character and v2.Health > 0))) then
        return false;
    end;

    AbilityUtils.clientCutsceneSkill(interface, AbilityBalancing.SnuffyRebellion, AbilityBalancing.SnuffyRebellion.Duration + 3, nil, false);

    return true;
end;