  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("ServerScriptService");
game:GetService("Players");
game:GetService("RunService");
game:GetService("TweenService");
local ReplicatedStorage2 = game:GetService("ReplicatedStorage");
require(ReplicatedStorage.Shared.Essentials);
require(ReplicatedStorage.Shared.Trove);
require(ReplicatedStorage.Shared.SoundManager);
require(ReplicatedStorage.Shared.Popup);
require(ReplicatedStorage.Shared.VfxManager);
local AbilityBalancing = require(ReplicatedStorage2.AbilityBalancing);
local AbilityUtils = require(ReplicatedStorage2.Shared.AbilityUtils);
local interface = require(ReplicatedStorage2.Controllers.AbilityController.interface);

local function Lerp(p1, p2, p3) -- Line: 17
    return p1 + (p2 - p1) * p3;
end;

local function QuadBezier(p4, p5, p6, p7) -- Line: 21
    local v8 = p4 + (p5 - p4) * p7;

    return v8 + (p5 + (p6 - p5) * p7 - v8) * p7;
end;

return function(u9, u10, u11, p12) -- Line: 29
    -- upvalues: AbilityBalancing (copy), AbilityUtils (copy), interface (ref)
    if u10.Character.Values.Stunned.Value then
        return;
    end;

    if u10.Character.IsRagdoll.Value then
        return;
    end;

    u9.StatesController.States.Ability = true;
    u9.StatesController.OwnWalkState = true;
    u9.StatesController.SpeedBoost = -10;
    u9.Animations.Abilities.CreativeDribble.Priority = Enum.AnimationPriority.Action4;
    u9.Animations.Abilities.CreativeDribble:Play();
    u9.Animations.Ball.CreativeDribbleBall.Priority = Enum.AnimationPriority.Action4;
    u9.Animations.Ball.CreativeDribbleBall:Play();
    local u13 = u10.PlayerStats.Style.Value == "Reo";
    u9:AbilityCooldown("2", u13 and 40 or 0.5);
    local HumanoidRootPart = u11.HumanoidRootPart;

    if u11.Values.HasBall.Value then
        u9.AbilityService.Ability:Fire("CreativeDribble", {
            State = "Nutmeg",
            target = p12
        });
        u9.Animations.Abilities.CreativeDribble.TimePosition = 0.2;
        u9.Animations.Ball.CreativeDribbleBall.TimePosition = 0.2;
        local v14 = HumanoidRootPart.CFrame * CFrame.new(0, 0, -5);
        local Vector3_new_ret = Vector3.new(v14.Position.X, HumanoidRootPart.Position.Y, v14.Position.Z);
        local CFrame_new_ret = CFrame.new(Vector3_new_ret, u10.Character.HumanoidRootPart.Position);
        local CFrame_new_ret2 = CFrame.new(HumanoidRootPart.Position, Vector3_new_ret);
        local Position = CFrame_new_ret2.Position;
        local Position2 = (CFrame_new_ret2 * CFrame.new(0, 0, -40)).Position;
        local _ = (Position - Position2).Magnitude;
        local Position3 = (CFrame.new(CFrame_new_ret.Position, Position2) * CFrame.new(-20, 0, 0)).Position;
        local AlignPosition = Instance.new("AlignPosition");
        AlignPosition.Mode = Enum.PositionAlignmentMode.OneAttachment;
        AlignPosition.Attachment0 = HumanoidRootPart:FindFirstChild("RootAttachment");
        AlignPosition.Responsiveness = 200;
        AlignPosition.MaxForce = 100000;
        AlignPosition.Position = Position;
        AlignPosition.Parent = HumanoidRootPart;
        local BodyGyro = Instance.new("BodyGyro");
        BodyGyro.Parent = u10.Character.HumanoidRootPart;
        BodyGyro.MaxTorque = Vector3.new(inf, inf, inf);

        for i = 1, 10 do
            local v15 = i / 10;
            local v16 = Position + (Position3 - Position) * v15;
            local v17 = game.TweenService:Create(AlignPosition, TweenInfo.new(0.05), {
                Position = v16 + (Position3 + (Position2 - Position3) * v15 - v16) * v15
            });
            v17:Play();
            v17.Completed:Wait();
            v17:Destroy();
            local _ = i;
        end;

        AlignPosition:Destroy();
        BodyGyro:Destroy();
        task.wait(0.3);
    else
        u9.AbilityService.Ability:Fire("CreativeDash", {});
        u9.Animations.Abilities.CreativeDribble.TimePosition = 1;
        u9.Animations.Ball.CreativeDribbleBall.TimePosition = 1;
    end;

    local LookVector = HumanoidRootPart.CFrame.LookVector;
    local Unit = Vector3.new(LookVector.X, 0, LookVector.Z).Unit;
    AbilityUtils.FastDashTo(u11, HumanoidRootPart.Position + Unit * (AbilityBalancing.CreativeDribble.TravelDistance * 1.5), -2, 0.5);
    task.wait(0.5);
    u9.ABC:Add(function() -- Line: 107
        -- upvalues: u9 (copy)
        u9.StatesController.OwnWalkState = false;
        u9.StatesController.States.Ability = false;
        u9.StatesController.SpeedBoost = 0;
    end);
    u9.ABC:Add(function() -- Line: 113
        -- upvalues: u9 (copy), u13 (copy), u11 (copy), u10 (copy), interface (ref)
        u9.StatesController.States.Ability = false;

        if u13 then
            return;
        end;

        if u11.Values.HasBall.Value then
            local v18 = u10.PlayerGui.InGameUI.Bottom.Abilities:FindFirstChild("2");

            if v18 then
                local UIScale = v18:FindFirstChild("UIScale");
                UIScale.Scale = 1.25;
                v18.ImageColor3 = Color3.fromRGB(26, 255, 53);
                u9.UITween1 = game:GetService("TweenService"):Create(UIScale, TweenInfo.new(0.85, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
                    Scale = 1
                });
                u9.UITween1:Play();
                u9.UITween2 = game:GetService("TweenService"):Create(v18, TweenInfo.new(0.85, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
                    ImageColor3 = Color3.fromRGB(255, 255, 255)
                });
                u9.UITween2:Play();
                interface.HeelFlick = true;
                task.delay(2, function() -- Line: 135
                    -- upvalues: u9 (ref), interface (ref)
                    u9.UITween2 = nil;
                    u9.UITween1 = nil;
                    interface = nil;
                    u9:AbilityCooldown("2", 40);
                end);
            end;
        else
            u9:AbilityCooldown("2", 40);
        end;
    end);
    u9.ABC:Clean();
end;