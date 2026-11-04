  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("ServerScriptService");
game:GetService("Players");
game:GetService("RunService");
game:GetService("TweenService");
game:GetService("RunService");
require(ReplicatedStorage.Shared.Essentials);
require(ReplicatedStorage.Shared.Trove);
require(ReplicatedStorage.Shared.SoundManager);
require(ReplicatedStorage.Shared.Popup);
require(ReplicatedStorage.Shared.VfxManager);
local Scorpion = require(ReplicatedStorage.AbilityBalancing).Scorpion;
local AbilityUtils = require(ReplicatedStorage.Shared.AbilityUtils);

return function(u1, p2, p3) -- Line: 17, Name: Scorpion
    -- upvalues: Scorpion (copy), AbilityUtils (copy)
    if p3.Values.HasBall.Value then
        return;
    end;

    if u1.AbilityOne > tick() then
        return;
    end;

    if u1.ABC then
        u1.ABC:Clean();
    end;

    local HumanoidRootPart = p3.HumanoidRootPart;
    local Humanoid = p3.Humanoid;
    u1:AbilityCooldown("1", Scorpion.Cooldown);
    local Unit = HumanoidRootPart.AssemblyLinearVelocity.Unit;
    local Unit2 = Vector3.new(Unit.X, 0, Unit.Z).Unit;
    local v4 = HumanoidRootPart.CFrame:VectorToObjectSpace(Unit2);
    local v5 = {};
    local math_clamp_ret = math.clamp(v4.X / Humanoid.WalkSpeed, 0.001, 1);
    v5.Left = math.abs(math_clamp_ret);
    local math_clamp_ret2 = math.clamp(v4.X / Humanoid.WalkSpeed, -1, -0.001);
    v5.Right = math.abs(math_clamp_ret2);
    local math_clamp_ret3 = math.clamp(v4.Z / Humanoid.WalkSpeed, -1, -0.001);
    v5.Back = math.abs(math_clamp_ret3);
    local math_clamp_ret4 = math.clamp(v4.Z / Humanoid.WalkSpeed, 0.001, 1);
    v5.Forward = math.abs(math_clamp_ret4);
    local v6 = 0;
    local v7 = "";

    for i, v in pairs(v5) do
        if v6 < v then
            v7 = i;
            v6 = v;
        end;
    end;

    local v8;

    if v7 == "Left" or v7 == "Right" then
        v8 = Vector3.new(-Unit2.X, 0, -Unit2.Z).Unit;
    else
        v8 = HumanoidRootPart.CFrame.LookVector;
    end;

    u1.AbilityService.Ability:Fire("InstinctsReaction", v7);
    task.delay(0.5, function() -- Line: 52
        -- upvalues: u1 (copy)
        u1.StatesController.States.Ability = false;
    end);
    u1.StatesController.States.Ability = true;
    u1.Animations.Abilities[v7 .. "IR"].Priority = Enum.AnimationPriority.Action4;
    u1.Animations.Abilities[v7 .. "IR"]:Play();
    AbilityUtils.FastDashTo(p3, HumanoidRootPart.Position + v8 * 25, -2, 0.5);
end;