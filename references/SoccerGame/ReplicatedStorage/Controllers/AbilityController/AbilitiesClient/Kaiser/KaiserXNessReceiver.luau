  

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local AbilityUtils = require(ReplicatedStorage.Shared.AbilityUtils);
local AbilityBalancing = require(ReplicatedStorage.AbilityBalancing);
local u1 = false;

return function(u2, p3, p4) -- Line: 12
    -- upvalues: u1 (ref), Players (copy), AbilityBalancing (copy), AbilityUtils (copy)
    if u1 or p3:GetAttribute("CRRequest") ~= "KaiserXNess" then
        return;
    end;

    local Attribute = p3:GetAttribute("CRRequestToken");
    local Attribute2 = p3:GetAttribute("CRSender");
    local v5;

    if p4 then
        v5 = p4:FindFirstChild("HumanoidRootPart");
    else
        v5 = p4;
    end;

    local v6;

    if p4 then
        v6 = p4:FindFirstChildOfClass("Humanoid");
    else
        v6 = p4;
    end;

    local v7;

    if p4 then
        v7 = p4:FindFirstChild("Values");
    else
        v7 = p4;
    end;

    if v7 then
        v7 = v7:FindFirstChild("InCutscene");
    end;

    local workspace_CurrentCamera = workspace.CurrentCamera;
    local v8;

    if typeof(Attribute2) == "number" then
        v8 = Players:GetPlayerByUserId(Attribute2) or nil;
    else
        v8 = nil;
    end;

    local v9;

    if v8 then
        v9 = v8:FindFirstChild("PlayerStats");
    else
        v9 = v8;
    end;

    if v9 then
        v9 = v9:FindFirstChild("Style");
    end;

    local v10;

    if v8 then
        v10 = v8.Character;
    else
        v10 = v8;
    end;

    local v11;

    if v10 then
        v11 = v10:FindFirstChildOfClass("Humanoid");
    else
        v11 = v10;
    end;

    if p3.Character ~= p4 or (typeof(Attribute) ~= "string" or (#Attribute == 0 or (typeof(Attribute2) ~= "number" or not (v5 and (v6 and (v6.Health > 0 and (v7 and (not v7.Value and (workspace_CurrentCamera and (u2.ABC and (v8 and (v8 ~= p3 and (p3.Team and (v8.Team == p3.Team and (v9 and (v9.Value == "Ness" and (v10 and (v11 and v11.Health > 0)))))))))))))))))) then
        return;
    end;

    local v12 = workspace_CurrentCamera.CFrame.LookVector + AbilityBalancing.KaiserXNess.ShotTiltVector;

    if v12.Magnitude < 0.001 then
        return;
    end;

    local Unit = v12.Unit;
    u1 = true;
    local success, result = pcall(function() -- Line: 64
        -- upvalues: u2 (copy), Attribute (copy), Attribute2 (copy)
        return u2.AbilityService:TryServerArmedChemicalReaction("KaiserXNess", {
            Token = Attribute,
            SenderUserId = Attribute2
        });
    end);
    u1 = false;

    if not (success and (result == true and (p3.Character == p4 and v6.Health > 0))) then
        return;
    end;

    AbilityUtils.clientCutsceneSkill(u2, AbilityBalancing.KaiserXNess, 16.5, nil, true, Unit);
end;