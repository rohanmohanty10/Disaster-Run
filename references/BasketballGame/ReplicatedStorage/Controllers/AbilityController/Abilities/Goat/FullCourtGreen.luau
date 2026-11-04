 
 

game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
game:GetService("RunService");
require(ReplicatedStorage.Packages.Knit);
require(ReplicatedStorage.Shared.Utility.CameraShaker);
require(ReplicatedStorage.Shared.Utility.Effects);
require(ReplicatedStorage.Shared.Utility.Essentials);
local _ = require(ReplicatedStorage.Shared.Tables.Cooldowns).Abilities;
require(ReplicatedStorage.Shared.Functions.CalculateBallTrajectory);
local u1 = nil;
local u2 = nil;
local u3 = nil;
local u4 = nil;
local LocalPlayer = game.Players.LocalPlayer;
local workspace_CurrentCamera = workspace.CurrentCamera;

return function(u5) -- Line: 21
    -- upvalues: LocalPlayer (copy), u1 (ref), u2 (ref), u3 (ref), u4 (ref), TweenService (copy), workspace_CurrentCamera (copy), ReplicatedStorage (copy)
    local Character = LocalPlayer.Character;
    local HumanoidRootPart = Character.HumanoidRootPart;
    local _ = Character.Humanoid;
    u1 = u5.AbilityService;
    u2 = u5.MovementController;
    u3 = u5.BallController;
    u4 = u5.Animations;
    local Position = workspace.Hoops[LocalPlayer.Team.Name].Hoop.Position;
    u2.States.Ability = true;
    task.delay(1.8833333333333333, function() -- Line: 34
        -- upvalues: u2 (ref)
        u2.States.Ability = false;
    end);
    task.spawn(function() -- Line: 38
        -- upvalues: TweenService (ref), workspace_CurrentCamera (ref)
        TweenService:Create(workspace_CurrentCamera, TweenInfo.new(0.7666666666666667), {
            FieldOfView = 50
        }):Play();
        task.wait(0.7666666666666667);
        TweenService:Create(workspace_CurrentCamera, TweenInfo.new(0.9333333333333333), {
            FieldOfView = 100
        }):Play();
        task.wait(0.9333333333333333);
        TweenService:Create(workspace_CurrentCamera, TweenInfo.new(1), {
            FieldOfView = 70
        }):Play();
    end);
    u4:StopAll();
    u4:PlayChar("Goat", "FullCourt", Enum.AnimationPriority.Action3);
    u4:PlayBall("Goat", "FullCourtBall", Enum.AnimationPriority.Action3);
    u1.Ability:Fire("Full Court Green", {
        TimeSent = workspace:GetServerTimeNow()
    });
    u5.AC:Connect(u1.Ability, function(p6) -- Line: 52
        -- upvalues: u5 (copy), ReplicatedStorage (ref), Position (copy), HumanoidRootPart (copy)
        if not p6 or p6.State ~= "Shot" then
            return;
        end;

        u5.AC:Clean();
        local Value = ReplicatedStorage.Basketball.Value;
        local _ = Value.Position;
        local v7 = Position - Value.Position;
        local v8, v9;

        if (HumanoidRootPart.Position - Position).Magnitude <= 30 then
            v8 = v7.Magnitude * 0.0455;
            v9 = 1.35;
        else
            v8 = v7.Magnitude * 0.04;
            v9 = 0.5;
        end;

        local math_log_ret = math.log(v9 + v8);
        Value.AssemblyLinearVelocity = v7 / math_log_ret + Vector3.new(0, workspace.Gravity * math_log_ret * 0.5, 0);
    end);
end;