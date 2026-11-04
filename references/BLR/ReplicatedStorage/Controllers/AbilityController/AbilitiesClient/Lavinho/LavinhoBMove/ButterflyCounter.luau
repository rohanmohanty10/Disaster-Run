  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("ServerScriptService");
local Players = game:GetService("Players");
game:GetService("RunService");
game:GetService("TweenService");
game:GetService("RunService");
game:GetService("TweenService");
game:GetService("Debris");
require(ReplicatedStorage.Shared.Popup);
local AbilityUtils = require(ReplicatedStorage.Shared.AbilityUtils);
local AbilityBalancing = require(ReplicatedStorage.AbilityBalancing);
require(ReplicatedStorage.Shared.SoundManager);
require(ReplicatedStorage.Modules.getPlayerTarget);
local Essentials = require(ReplicatedStorage.Shared.Essentials);

return function(u1, u2, u3) -- Line: 17, Name: ButterflyCounter
    -- upvalues: AbilityBalancing (copy), AbilityUtils (copy), ReplicatedStorage (copy), Essentials (copy), Players (copy)
    if u1.ABC then
        u1.ABC:Clean();
    end;

    local HumanoidRootPart = u3.HumanoidRootPart;
    u1:AbilityCooldown("3", 35);
    u1.AbilityService.Ability:Fire("ButterflyCounter", {
        State = "Start"
    });
    u1.StatesController.States.Ability = true;
    u1.Animations:StopAnims();
    u1.Animations.Abilities.ButterflyCounter.Priority = Enum.AnimationPriority.Action4;
    u1.Animations.Abilities.ButterflyCounter:Play();
    u1.Animations.Ball.ButterflyCounterBall.Priority = Enum.AnimationPriority.Action4;
    u1.Animations.Ball.ButterflyCounterBall:Play();
    u3:SetAttribute("IFrames", true);
    local u4 = false;

    local function Dash() -- Line: 37
        -- upvalues: u4 (ref), u1 (copy), u3 (copy), AbilityBalancing (ref), AbilityUtils (ref)
        if u4 then
            return;
        end;

        u4 = true;
        u1.Animations.Ball.ButterflyCounterBall:Stop();
        u1.Animations.Abilities.ButterflyCounter:Stop();
        u1.Animations.Abilities.ButterflyCounterDash.Priority = Enum.AnimationPriority.Action4;
        u1.Animations.Abilities.ButterflyCounterDash:Play();
        u1.Animations.Ball.ButterflyCounterDashBall.Priority = Enum.AnimationPriority.Action4;
        u1.Animations.Ball.ButterflyCounterDashBall:Play();
        u1.AbilityService.Ability:Fire("ButterflyCounter", {
            State = "Dash"
        });
        task.delay(0.45, function() -- Line: 51
            -- upvalues: u3 (ref), AbilityBalancing (ref), AbilityUtils (ref), u1 (ref)
            local v5 = -u3.HumanoidRootPart.CFrame.RightVector;
            local Unit = Vector3.new(v5.X, 0, v5.Z).Unit;
            AbilityUtils.FastDashTo(u3, u3.HumanoidRootPart.Position + Unit * AbilityBalancing.ButterflyCounter.DashDistance, 2, 0.5);

            if u1.ABC then
                u1.ABC:Clean();
            end;
        end);
    end;

    task.delay(AbilityBalancing.ButterflyCounter.Duration, Dash);
    local u6 = ReplicatedStorage.Assets.Misc.DiveHitbox:Clone();
    u6.Transparency = 1;
    u6.Parent = HumanoidRootPart.Parent;
    u6.CFrame = HumanoidRootPart.CFrame;
    Essentials:Weld(u6, HumanoidRootPart);
    game.Debris:AddItem(u6, AbilityBalancing.ButterflyCounter.Duration);
    u1.ABC:Add(function() -- Line: 71
        -- upvalues: u1 (copy), u3 (copy)
        u1.StatesController.States.Ability = false;
        u3:SetAttribute("IFrames", false);
    end);
    u1.ABC:Connect(u6.Touched, function(p7) -- Line: 76
        -- upvalues: u2 (copy), Players (ref), u6 (copy), Dash (copy)
        if p7.Parent:FindFirstChild("Humanoid") and p7.Parent ~= u2.Character then
            local v8 = Players:FindFirstChild(p7.Parent.Name);

            if v8 and v8.Team == u2.Team then
                return;
            end;

            if p7.Parent.Values.Goalie.Value == true and p7.Parent.Values.IsInPenalty.Value == true then
                return;
            end;

            u6:Destroy();
            Dash();
        end;
    end);
    task.delay(1.5, function() -- Line: 93
        -- upvalues: u1 (copy)
        if u1.ABC then
            u1.ABC:Clean();
        end;
    end);
end;