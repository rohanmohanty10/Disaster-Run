  

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

return function(u1, p2, p3) -- Line: 17, Name: GingaShot
    -- upvalues: AbilityBalancing (copy), RunService (copy), ReplicatedStorage (copy)
    u1:AbilityCooldown("2", 47);
    u1.StatesController.States.Ability = true;
    u1.Animations:StopAnims();
    u1.Animations.Abilities.GingaShot.Priority = Enum.AnimationPriority.Action4;
    u1.Animations.Abilities.GingaShot:Play();
    u1.AbilityService.Ability:Fire("GingaShot");
    local ShotPower = AbilityBalancing.GingaShot.ShotPower;
    u1.ABC:Connect(u1.AbilityService.Ability, function(u4, u5) -- Line: 31
        -- upvalues: u1 (copy), ShotPower (copy), RunService (ref), ReplicatedStorage (ref)
        u1.StatesController.States.Ability = false;
        u4.AssemblyLinearVelocity = (game.Workspace.CurrentCamera.CFrame.LookVector + Vector3.new(0, 0.2, 0) + u5 / 4) * ShotPower;
        task.delay(0.1, function() -- Line: 38
            -- upvalues: u1 (ref), RunService (ref), u4 (copy), u5 (copy)
            local u6 = -43;
            u1.ABC:Connect(RunService.Heartbeat, function(p7) -- Line: 41
                -- upvalues: u6 (ref), u1 (ref), u4 (ref), u5 (ref)
                u6 = u6 + 50 * p7;

                if u6 >= -30 then
                    print("Ended");
                    u1.ABC:Clean();
                end;

                u4.AssemblyLinearVelocity = u4.AssemblyLinearVelocity:Lerp(u4.AssemblyLinearVelocity + u5 * u6, 8 * p7);
            end);
        end);
        u1.BallController:DragBall(ReplicatedStorage.Football.Value);
    end);
    task.delay(2.5, function() -- Line: 53
        -- upvalues: u1 (copy)
        u1.StatesController.States.Ability = false;

        if u1.ABC then
            u1.ABC:Clean();
        end;
    end);
end;