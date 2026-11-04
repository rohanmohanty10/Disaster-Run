  

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

return function(u1, u2, p3) -- Line: 17
    -- upvalues: AbilityBalancing (copy), RunService (copy), ReplicatedStorage (copy)
    if p3.Values.HasBall.Value == false then
        return;
    end;

    if u1.AbilityTwo > tick() then
        return;
    end;

    if u1.ABC then
        u1.ABC:Clean();
    end;

    local HumanoidRootPart = p3.HumanoidRootPart;
    u1:AbilityCooldown("2", AbilityBalancing.SnakeClear.Cooldown);
    u1.StatesController.States.Ability = true;
    u1.Animations:StopAnims();
    u1.Animations.Abilities.SnakeShot.Priority = Enum.AnimationPriority.Action4;
    u1.Animations.Abilities.SnakeShot:Play();
    u1.AbilityService.Ability:Fire("SnakeShot");
    u1.ABC:Add(task.delay(1.5, function() -- Line: 34
        -- upvalues: u1 (copy)
        if u1.ABC then
            u1.StatesController.States.Ability = false;
            u1.ABC:Clean();
        end;
    end));
    u1.ABC:Connect(u1.AbilityService.Ability, function(u4) -- Line: 42
        -- upvalues: AbilityBalancing (ref), u1 (copy), u2 (copy), HumanoidRootPart (copy), RunService (ref), ReplicatedStorage (ref)
        local LookVector = game.Workspace.CurrentCamera.CFrame.LookVector;

        if LookVector.Y > 0.2 then
            LookVector = Vector3.new(LookVector.X, 0.2, LookVector.Z);
        end;

        local ShotPower = AbilityBalancing.SnakeClear.ShotPower;
        local Unit = LookVector.Unit;
        u4.AssemblyLinearVelocity = Unit * ShotPower;
        u1.ABC:Add(function() -- Line: 59
            -- upvalues: u2 (ref), HumanoidRootPart (ref), u4 (copy), Unit (copy), ShotPower (copy), u1 (ref)
            local v5 = workspace.Goals:FindFirstChild(u2.Team.Name);
            local v6;

            if v5.Name == "Away" then
                v6 = workspace.Goals.Home;
            else
                v6 = workspace.Goals.Away;
            end;

            if (v5.Position - v6.Position).Magnitude / 2 < (v5.Position - HumanoidRootPart.Position).Magnitude == true then
                u4.AssemblyLinearVelocity = Unit * ShotPower;
            else
                u4.AssemblyLinearVelocity = Unit * 80;
            end;

            task.wait(0.5);
            u1.StatesController.States.Ability = false;
        end);
        task.delay(0.1, function() -- Line: 84
            -- upvalues: Unit (copy), u1 (ref), RunService (ref), u4 (copy), ShotPower (copy)
            local u7 = tick();
            local Unit2 = Unit:Cross(Vector3.new(0, 1, 0)).Unit;
            u1.ABC:Connect(RunService.Heartbeat, function(p8) -- Line: 93
                -- upvalues: u7 (copy), u4 (ref), Unit (ref), ShotPower (ref), Unit2 (copy), u1 (ref)
                local v9 = tick() - u7;
                local v10 = math.sin(v9 * 3 * 3.141592653589793 * 2) * 100;
                u4.AssemblyLinearVelocity = Unit * ShotPower + Unit2 * v10;

                if v9 >= 2 then
                    u1.ABC:Clean();
                end;
            end);
        end);
        u1.BallController:DragBall(ReplicatedStorage.Football.Value);
    end);
end;