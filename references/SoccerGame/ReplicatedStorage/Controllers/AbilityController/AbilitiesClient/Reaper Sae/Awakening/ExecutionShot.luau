  

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
local Popup = require(ReplicatedStorage.Shared.Popup);
require(ReplicatedStorage.Shared.VfxManager);
require(ReplicatedStorage.Shared.AbilityUtils);
local ExecutionShot = require(ReplicatedStorage.AbilityBalancing).ExecutionShot;

return function(u1, u2, u3) -- Line: 19
    -- upvalues: Popup (copy), ExecutionShot (copy), RunService (copy), ReplicatedStorage (copy)
    if u2.Character.Values.HasBall.Value == false then
        return;
    end;

    if u1.AbilityTwo > tick() then
        return;
    end;

    if u1.AbilityUsed > tick() then
        return;
    end;

    if u1.ABC then
        u1.ABC:Clean();
    end;

    if u3.Humanoid:GetState() == Enum.HumanoidStateType.Freefall then
        return;
    end;

    local BallSpawn = workspace:WaitForChild("BallSpawn");
    local HumanoidRootPart = u3:WaitForChild("HumanoidRootPart");

    local function isOnEnemySide(p4: string) -- Line: 32
        -- upvalues: BallSpawn (copy), HumanoidRootPart (copy)
        local v5 = BallSpawn.CFrame.RightVector:Dot(HumanoidRootPart.Position - BallSpawn.Position);

        if p4 == "Home" then
            return v5 < 0;
        end;

        if p4 == "Away" then
            return v5 > 0;
        end;
    end;

    local Name = u2.Team.Name;
    local v6 = BallSpawn.CFrame.RightVector:Dot(HumanoidRootPart.Position - BallSpawn.Position);
    local v7;

    if Name == "Home" then
        v7 = v6 < 0;
    elseif Name == "Away" then
        v7 = v6 > 0;
    else
        v7 = nil;
    end;

    if not v7 then
        Popup.Popup(u2, "Must be on enemy half of pitch");

        return;
    end;

    u1.Camera.Cutscene = true;
    u1.InAbility = true;
    u1.StatesController.States.Ability = true;
    u3.HumanoidRootPart.Anchored = true;
    u1.ABC:Add(function() -- Line: 58
        -- upvalues: u1 (copy), u3 (copy)
        u1.Camera.Cutscene = false;
        u1.InAbility = false;
        u1.StatesController.States.Ability = false;
        u3.HumanoidRootPart.Anchored = false;
    end);
    u1:AbilityCooldown("2", 75);
    u1.AbilityService.Ability:Fire("ExecutionShot");
    u1.ABC:Add(task.delay(12, function() -- Line: 69
        -- upvalues: u1 (copy)
        u1.ABC:Clean();
    end));
    local LookVector = workspace.CurrentCamera.CFrame.LookVector;
    u1.ABC:Connect(u1.AbilityService.Ability, function(u8, u9) -- Line: 75
        -- upvalues: u2 (copy), LookVector (copy), ExecutionShot (ref), RunService (ref), u1 (copy), ReplicatedStorage (ref)
        local Character = u2.Character;

        if Character then
            Character = Character:FindFirstChild("HumanoidRootPart");
        end;

        if not Character then
            return;
        end;

        u8.AssemblyLinearVelocity = (LookVector + Vector3.new(0, 0.2, 0) + u9 / 2) * ExecutionShot.ShotPower;
        task.delay(0.1, function() -- Line: 85
            -- upvalues: RunService (ref), u8 (copy), u9 (copy)
            local u10 = -43;
            local u11 = nil;
            u11 = RunService.Heartbeat:Connect(function(p12) -- Line: 89
                -- upvalues: u10 (ref), u11 (ref), u8 (ref), u9 (ref)
                u10 = u10 + 50 * p12;

                if u10 >= -25 then
                    u11:Disconnect();
                end;

                u8.AssemblyLinearVelocity = u8.AssemblyLinearVelocity:Lerp(u8.AssemblyLinearVelocity + u9 * u10, 8 * p12);
            end);
        end);
        u1.BallController:DragBall(ReplicatedStorage.Football.Value);
        u1.ABC:Clean();
    end);
end;