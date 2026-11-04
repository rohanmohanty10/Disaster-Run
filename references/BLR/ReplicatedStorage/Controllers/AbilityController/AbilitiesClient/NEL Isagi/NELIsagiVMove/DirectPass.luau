  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("ServerScriptService");
game:GetService("Players");
local RunService = game:GetService("RunService");
game:GetService("TweenService");
game:GetService("RunService");
game:GetService("TweenService");
game:GetService("Debris");
require(ReplicatedStorage.Shared.Essentials);
require(ReplicatedStorage.Shared.Trove);
require(ReplicatedStorage.Shared.SoundManager);
local Popup = require(ReplicatedStorage.Shared.Popup);
require(ReplicatedStorage.Shared.VfxManager);
require(ReplicatedStorage.Shared.AbilityUtils);
local AbilityBalancing = require(ReplicatedStorage.AbilityBalancing);

return function(u1, p2, p3) -- Line: 18, Name: NELDash
    -- upvalues: RunService (copy), Popup (copy), AbilityBalancing (copy)
    if u1.AbilityTwo > tick() then
        return;
    end;

    if u1.ABC then
        u1.ABC:Clean();
    end;

    local HumanoidRootPart = p3:FindFirstChild("HumanoidRootPart");

    if not HumanoidRootPart then
        return;
    end;

    local _ = workspace.CurrentCamera;
    local u4 = RunService:IsStudio() and workspace.PassRig or u1.BallController.Closest;
    local HumanoidRootPart2 = u4:FindFirstChild("HumanoidRootPart");

    if not HumanoidRootPart2 then
        return;
    end;

    local u5 = false;

    if (HumanoidRootPart.Position - HumanoidRootPart2.Position).Magnitude >= 150 then
        Popup.Popup(p2, "Teammate too far");

        return;
    end;

    u1:AbilityCooldown("2", 40);
    u1.StatesController.States.Ability = true;
    u1.ABC:Add(function() -- Line: 42
        -- upvalues: u1 (copy), u5 (ref)
        u1.StatesController.States.Ability = false;
        u5 = true;
    end);
    u1.Animations.Abilities.NELDirectPass.Priority = Enum.AnimationPriority.Action3;
    u1.Animations.Abilities.NELDirectPass.Looped = false;
    u1.Animations.Abilities.NELDirectPass:Play();
    u1.Animations.Ball.NELDirectPassBall.Priority = Enum.AnimationPriority.Action4;
    u1.Animations.Ball.NELDirectPassBall.Looped = false;
    u1.Animations.Ball.NELDirectPassBall:Play();
    u1.AbilityService.Ability:Fire("NELDirectPass", u4);
    u1.ABC:Connect(u1.AbilityService.Ability, function(u6, p7) -- Line: 59
        -- upvalues: u1 (copy), u4 (copy), HumanoidRootPart (copy), AbilityBalancing (ref), RunService (ref)
        u1.ABC:Clean();
        local Vector3_new_ret = Vector3.new(u4.HumanoidRootPart.AssemblyLinearVelocity.X, 0, u4.HumanoidRootPart.AssemblyLinearVelocity.Z);
        local Position = u4.HumanoidRootPart.Position;
        local u8 = (Position + Vector3_new_ret - HumanoidRootPart.Position).Unit + Vector3.new(0, 0.02, 0);
        local u9 = (Position - HumanoidRootPart.Position).Magnitude * AbilityBalancing.NELDirectPass.PassSpeed;
        u6.AssemblyLinearVelocity = u8 * u9;
        u1.BallController:DragBall(u6);
        local u10 = tick();
        local u11 = nil;
        u11 = RunService.Heartbeat:Connect(function() -- Line: 73
            -- upvalues: u10 (copy), AbilityBalancing (ref), u6 (copy), u11 (ref), u4 (ref), Vector3_new_ret (ref), u8 (copy), u9 (copy)
            if tick() - u10 >= AbilityBalancing.NELDirectPass.PassTime then
                u6.AssemblyLinearVelocity = Vector3.new(0, 0, 0);
                u11:Disconnect();

                return;
            end;

            if (u6.Position - u4.HumanoidRootPart.Position).Magnitude <= 10 then
                u11:Disconnect();

                return;
            end;

            Vector3_new_ret = Vector3.new(u4.HumanoidRootPart.AssemblyLinearVelocity.X, 0, u4.HumanoidRootPart.AssemblyLinearVelocity.Z);
            u8:Lerp((u4.HumanoidRootPart.Position + Vector3_new_ret - u6.Position).Unit + Vector3.new(0, 0.22, 0), 1.5);
            u6.AssemblyLinearVelocity = u6.AssemblyLinearVelocity:Lerp(u8 * u9, 1);
        end);
    end);
    task.delay(1.5, function() -- Line: 89
        -- upvalues: u5 (ref), u1 (copy)
        if not u5 then
            u1.ABC:Clean();
        end;
    end);
end;