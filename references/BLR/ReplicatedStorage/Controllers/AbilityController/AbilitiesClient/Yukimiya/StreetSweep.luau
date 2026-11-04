  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("ServerScriptService");
game:GetService("Players");
game:GetService("RunService");
game:GetService("TweenService");
local ReplicatedStorage2 = game:GetService("ReplicatedStorage");
require(ReplicatedStorage.Shared.Essentials);
require(ReplicatedStorage.Shared.Trove);
require(ReplicatedStorage.Shared.SoundManager);
local Popup = require(ReplicatedStorage.Shared.Popup);
require(ReplicatedStorage.Shared.VfxManager);
local AbilityBalancing = require(ReplicatedStorage2.AbilityBalancing);
require(ReplicatedStorage2.Shared.AbilityUtils);
local interface = require(ReplicatedStorage2.Controllers.AbilityController.interface);

local function Lerp(p1, p2, p3) -- Line: 17
    return p1 + (p2 - p1) * p3;
end;

local function QuadBezier(p4, p5, p6, p7) -- Line: 21
    local v8 = p4 + (p5 - p4) * p7;

    return v8 + (p5 + (p6 - p5) * p7 - v8) * p7;
end;

local function CreateCurveMover(p9, p10, p11, p12) -- Line: 29
    -- upvalues: AbilityBalancing (copy)
    local TravelDistance = AbilityBalancing.StreetSweep.TravelDistance;
    local Position = p9.Position;
    local Position2 = p10.Position;
    local _ = (Position - Position2).Magnitude;
    local Position3 = (p9.CFrame * CFrame.new(TravelDistance * 1.75 * p11, 0, -TravelDistance / 2)).Position;
    local AlignPosition = Instance.new("AlignPosition");
    AlignPosition.Mode = Enum.PositionAlignmentMode.OneAttachment;
    AlignPosition.Attachment0 = p9:FindFirstChild("RootAttachment");
    AlignPosition.Responsiveness = 200;
    AlignPosition.MaxForce = 40000;
    AlignPosition.Position = Position;
    AlignPosition.Parent = p9;

    for i = 1, 10 do
        local v13 = i / 10;
        local v14 = Position + (Position3 - Position) * v13;
        local v15 = game.TweenService:Create(AlignPosition, TweenInfo.new(0.08, p12), {
            Position = v14 + (Position3 + (Position2 - Position3) * v13 - v14) * v13
        });
        v15:Play();
        v15.Completed:Wait();
        v15:Destroy();
        local _ = i;
    end;

    AlignPosition:Destroy();
end;

return function(u16, p17, p18) -- Line: 59
    -- upvalues: Popup (copy), interface (copy), AbilityBalancing (copy), CreateCurveMover (copy)
    if u16.AbilityTwo > tick() then
        return;
    end;

    if u16.AbilityUsed > tick() then
        return;
    end;

    if not p18.Values.HasBall.Value then
        Popup.Popup(p17, "You must have the ball!");

        return;
    end;

    if p18.Humanoid:GetState() == Enum.HumanoidStateType.Jumping or p18.Humanoid:GetState() == Enum.HumanoidStateType.Freefall then
        return;
    end;

    if p17.Character.IsRagdoll.Value then
        return;
    end;

    if p17.Character.Values.Stunned.Value then
        return;
    end;

    u16.StatesController.States.Ability = true;
    u16.StatesController.OwnWalkState = true;
    u16.Animations.Abilities.StreetSweep.Priority = Enum.AnimationPriority.Action4;
    u16.Animations.Abilities.StreetSweep:Play();
    u16.Animations.Ball.StreetSweepBall.Priority = Enum.AnimationPriority.Action4;
    u16.Animations.Ball.StreetSweepBall:Play();
    u16:AbilityCooldown("2", 30);
    local HumanoidRootPart = p18.HumanoidRootPart;
    local Shiftlock = u16.Camera.Shiftlock;
    interface.GyroShot = true;
    u16.ABC:Add(function() -- Line: 83
        -- upvalues: u16 (copy), Shiftlock (copy)
        u16.StatesController.OwnWalkState = false;
        u16.StatesController.States.Ability = false;
        u16.Camera:SetShiftlock(Shiftlock);
    end);
    local TravelDistance = AbilityBalancing.StreetSweep.TravelDistance;
    local CFrame2 = HumanoidRootPart.CFrame;
    u16.AbilityService.Ability:Fire("CreativeDash", {});
    u16.AbilityService.Ability:Fire("StreetSweep");
    u16.Camera:SetShiftlock(false);
    CreateCurveMover(HumanoidRootPart, CFrame2 * CFrame.new(0, 0, -TravelDistance), 1, Enum.EasingStyle.Linear);
    CreateCurveMover(HumanoidRootPart, CFrame2 * CFrame.new(0, 0, -TravelDistance * 2), -1, Enum.EasingStyle.Sine);
    print("cleaning");
    task.delay(0.1, function() -- Line: 115
        -- upvalues: u16 (copy)
        u16.ABC:Clean();
    end);
end;