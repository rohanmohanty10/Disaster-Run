  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("ServerScriptService");
game:GetService("Players");
game:GetService("RunService");
local TweenService = game:GetService("TweenService");
game:GetService("RunService");
game:GetService("Debris");
require(ReplicatedStorage.Shared.Essentials);
require(ReplicatedStorage.Shared.Trove);
require(ReplicatedStorage.Shared.SoundManager);
require(ReplicatedStorage.Shared.Popup);
require(ReplicatedStorage.Shared.VfxManager);
local RavenDribble = require(ReplicatedStorage.AbilityBalancing).RavenDribble;

return function(u1, p2, p3) -- Line: 15, Name: RavenDribble
    -- upvalues: RavenDribble (copy), TweenService (copy)
    if u1.AbilityOne > tick() then
        return;
    end;

    if p3.Values.HasBall.Value == false then
        return;
    end;

    if u1.ABC then
        u1.ABC:Clean();
    end;

    u1:AbilityCooldown("1", RavenDribble.Cooldown);
    u1.StatesController.States.Ability = true;
    task.delay(0.9, function() -- Line: 24
        -- upvalues: u1 (copy)
        u1.StatesController.States.Ability = false;
    end);
    local HumanoidRootPart = p2.Character.HumanoidRootPart;
    local Humanoid = p2.Character.Humanoid;
    local v4 = HumanoidRootPart.CFrame:VectorToObjectSpace(Humanoid.MoveDirection);
    print(Humanoid.WalkSpeed);
    local v5 = {};
    local math_clamp_ret = math.clamp(v4.X / Humanoid.WalkSpeed, 0.001, 1);
    v5.Right = math.abs(math_clamp_ret);
    local math_clamp_ret2 = math.clamp(v4.X / Humanoid.WalkSpeed, -1, -0.001);
    v5.Left = math.abs(math_clamp_ret2);
    local math_clamp_ret3 = math.clamp(v4.Z / Humanoid.WalkSpeed, -1, -0.001);
    v5.Forward = math.abs(math_clamp_ret3);
    local math_clamp_ret4 = math.clamp(v4.Z / Humanoid.WalkSpeed, 0.001, 1);
    v5.Back = math.abs(math_clamp_ret4);
    u1.Animations:StopAnims();
    local _ = HumanoidRootPart.CFrame.LookVector;
    local v6;

    if v5.Right > 0.1 then
        v6 = HumanoidRootPart.CFrame.RightVector;
    else
        v6 = -HumanoidRootPart.CFrame.RightVector;
    end;

    u1.Animations.Abilities.RavenDribble.Priority = Enum.AnimationPriority.Action3;
    u1.Animations.Abilities.RavenDribble:Play();
    u1.Animations.Ball.RavenDribble.Priority = Enum.AnimationPriority.Action3;
    u1.Animations.Ball.RavenDribble:Play();
    u1.AbilityService.Ability:Fire("RavenDribble", { v6, workspace:GetServerTimeNow() });
    u1.Camera.Cutscene = true;
    TweenService:Create(game.Workspace.CurrentCamera, TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
        FieldOfView = 40
    }):Play();
    task.delay(0.6, function() -- Line: 63
        -- upvalues: u1 (copy), TweenService (ref)
        u1.Camera.Cutscene = false;
        TweenService:Create(game.Workspace.CurrentCamera, TweenInfo.new(2, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
            FieldOfView = 70
        }):Play();
    end);
end;