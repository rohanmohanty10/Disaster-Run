  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("ServerScriptService");
game:GetService("Players");
game:GetService("RunService");
game:GetService("TweenService");
local RunService = game:GetService("RunService");
game:GetService("TweenService");
game:GetService("Debris");
require(ReplicatedStorage.Shared.Essentials);
require(ReplicatedStorage.Shared.Trove);
require(ReplicatedStorage.Shared.SoundManager);
require(ReplicatedStorage.Shared.Popup);
require(ReplicatedStorage.Shared.VfxManager);
local AbilityBalancing = require(ReplicatedStorage.AbilityBalancing);
local interface = require(ReplicatedStorage.Controllers.AbilityController.interface);

return function(u1, p2, p3) -- Line: 18, Name: Trivela
    -- upvalues: interface (copy), AbilityBalancing (copy), RunService (copy), ReplicatedStorage (copy)
    interface:AbilityCooldown(2, AbilityBalancing.ElasticNutmeg.Cooldown);
    interface.TrivelaShot = nil;
    p3:SetAttribute("Trivela", nil);
    u1.StatesController.States.Ability = true;
    u1.Animations:StopAnims();
    u1.Animations.Abilities.TrivelaShot.Priority = Enum.AnimationPriority.Action4;
    u1.Animations.Abilities.TrivelaShot:Play();
    u1.Animations.Ball.CurveShot.Priority = Enum.AnimationPriority.Action4;
    u1.Animations.Ball.CurveShot:Play();
    print("trivela");
    u1.AbilityService.Ability:Fire("Trivela");
    u1.ABC:Connect(u1.AbilityService.Ability, function(u4, u5) -- Line: 39
        -- upvalues: u1 (copy), AbilityBalancing (ref), RunService (ref), ReplicatedStorage (ref)
        print("Here");
        u1.StatesController.States.Ability = false;
        u4.AssemblyLinearVelocity = (game.Workspace.CurrentCamera.CFrame.LookVector + Vector3.new(0, 0.2, 0) + u5 / 2) * AbilityBalancing.Trivela.ShotPower;
        task.delay(0.1, function() -- Line: 47
            -- upvalues: u1 (ref), RunService (ref), u4 (copy), u5 (copy)
            local u6 = -43;
            u1.ABC:Connect(RunService.Heartbeat, function(p7) -- Line: 50
                -- upvalues: u6 (ref), u1 (ref), u4 (ref), u5 (ref)
                u6 = u6 + 50 * p7;

                if u6 >= -25 then
                    u1.ABC:Clean();
                end;

                u4.AssemblyLinearVelocity = u4.AssemblyLinearVelocity:Lerp(u4.AssemblyLinearVelocity + u5 * u6, 8 * p7);
            end);
        end);
        u1.BallController:DragBall(ReplicatedStorage.Football.Value);
    end);
    task.delay(2.5, function() -- Line: 61
        -- upvalues: u1 (copy)
        u1.StatesController.States.Ability = false;

        if u1.ABC then
            u1.ABC:Clean();
        end;
    end);
end;