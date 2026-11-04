  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("ServerScriptService");
game:GetService("Players");
game:GetService("RunService");
game:GetService("TweenService");
game:GetService("RunService");
game:GetService("TweenService");
game:GetService("Debris");
require(ReplicatedStorage.Shared.Essentials);
require(ReplicatedStorage.Shared.Trove);
require(ReplicatedStorage.Shared.SoundManager);
local Popup = require(ReplicatedStorage.Shared.Popup);
require(ReplicatedStorage.Shared.VfxManager);
local SixthSense = require(ReplicatedStorage.AbilityBalancing).SixthSense;

return function(u1, p2, u3) -- Line: 16, Name: Move
    -- upvalues: Popup (copy), SixthSense (copy)
    local HumanoidRootPart = u3:FindFirstChild("HumanoidRootPart");
    local v4 = workspace.PenaltyArea:FindFirstChild(p2.Team.Name);

    if not (HumanoidRootPart and v4) then
        return "";
    end;

    if not u3.Values.IsInPenalty.Value or (HumanoidRootPart.Position - v4.Position).Magnitude > 200 then
        return;
    end;

    if u3.Values.HasBall.Value then
        Popup.Popup(p2, "Must not have the ball!");

        return;
    end;

    if u1.AbilityThree > tick() then
        return;
    end;

    if u1.ABC then
        u1.ABC:Clean();
    end;

    u1.AbilityService.Ability:Fire("Territory", "SixthSense");
    u1.Animations:StopAnims();
    u1.Animations.Movement.SixthSenseIdle.Priority = Enum.AnimationPriority.Action2;
    u1.Animations.Movement.SixthSenseIdle:Play();
    u3:SetAttribute("CustomIdle", "SixthSenseIdle");
    local u5 = nil;
    u5 = u3:GetAttributeChangedSignal("SixthSense"):Connect(function() -- Line: 45
        -- upvalues: u3 (copy), u5 (ref), u1 (copy), SixthSense (ref)
        if not u3:GetAttribute("SixthSense") then
            u5:Disconnect();
            u1:AbilityCooldown("3", SixthSense.Cooldown);
            u3:SetAttribute("CustomIdle", nil);
            u1.Animations.Movement.SixthSenseIdle:Stop();
        end;
    end);
end;