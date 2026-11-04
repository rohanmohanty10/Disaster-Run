  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("ServerScriptService");
game:GetService("Players");
game:GetService("RunService");
game:GetService("TweenService");
local RunService = game:GetService("RunService");
game:GetService("TweenService");
game:GetService("Debris");
local ReplicatedStorage2 = game:GetService("ReplicatedStorage");
require(ReplicatedStorage.Shared.Essentials);
require(ReplicatedStorage.Shared.Trove);
require(ReplicatedStorage.Shared.SoundManager);
require(ReplicatedStorage.Shared.Popup);
require(ReplicatedStorage.Shared.VfxManager);
local AbilityBalancing = require(ReplicatedStorage2.AbilityBalancing);

return function(u1, p2, p3) -- Line: 18, Name: PowerShot
    -- upvalues: RunService (copy), AbilityBalancing (copy), ReplicatedStorage (copy)
    if p3.Values.HasBall.Value == false then
        return;
    end;

    if u1.AbilityOne > tick() then
        return;
    end;

    if u1.ABC then
        u1.ABC:Clean();
    end;

    u1:AbilityCooldown("1", 55);
    u1.StatesController.States.Ability = true;
    u1.Animations:StopAnims();
    u1.Animations.Abilities.PowerShot.Priority = Enum.AnimationPriority.Action4;
    u1.Animations.Abilities.PowerShot:Play();
    u1.Animations.Abilities.PowerShot:AdjustSpeed(1.5);

    if u1.ABC then
        u1.ABC:Clean();
    end;

    u1.AbilityService.Ability:Fire("PowerShot");
    local HumanoidRootPart = p3.HumanoidRootPart;
    local BodyVelocity = Instance.new("BodyVelocity");
    BodyVelocity.Parent = HumanoidRootPart;
    BodyVelocity.MaxForce = Vector3.new(inf, inf, inf);
    local u4 = 35;
    local _ = HumanoidRootPart.CFrame.LookVector;
    u1.ABC:Connect(RunService.Heartbeat, function(p5) -- Line: 44
        -- upvalues: BodyVelocity (copy), HumanoidRootPart (copy), u4 (ref)
        if BodyVelocity == nil then
            return;
        end;

        local LookVector = workspace.CurrentCamera.CFrame.LookVector;
        print(LookVector);
        BodyVelocity.Velocity = Vector3.new(LookVector.X, HumanoidRootPart.CFrame.LookVector.Y, LookVector.Z) * u4;
        u4 = u4 - p5 * 25;
    end);
    task.delay(0.5333333333333333, function() -- Line: 53
        -- upvalues: u1 (copy), BodyVelocity (copy)
        u1.Animations.Abilities.PowerShot:AdjustSpeed(1);
        BodyVelocity:Destroy();
    end);
    local u6 = nil;
    task.delay(1, function() -- Line: 61
        -- upvalues: u1 (copy)
        u1.StatesController.States.Ability = false;

        if u1.ABC then
            u1.ABC:Clean();
        end;
    end);
    u1.ABC:Connect(u1.AbilityService.Ability, function(p7) -- Line: 68
        -- upvalues: u6 (ref), u1 (copy), AbilityBalancing (ref), ReplicatedStorage (ref)
        u6 = p7 or workspace:WaitForChild("Football", 1);
        u1.Camera.Cutscene = false;
        u1.StatesController.States.Ability = false;
        u6.AssemblyLinearVelocity = (game.Workspace.CurrentCamera.CFrame.LookVector + AbilityBalancing.PowerShot.ShotTiltVector) * AbilityBalancing.PowerShot.ShotPower;
        u1.BallController:DragBall(ReplicatedStorage.Football.Value);
        u1.ABC:Clean();
    end);
end;