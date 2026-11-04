 
 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("Players");
game:GetService("TweenService");
local RunService = game:GetService("RunService");
require(ReplicatedStorage.Packages.Knit);
local Essentials = require(ReplicatedStorage.Shared.Utility.Essentials);
require(ReplicatedStorage.Shared.Utility.CameraShaker);
local Effects = require(ReplicatedStorage.Shared.Utility.Effects);
local u1 = nil;
local u2 = nil;
local u3 = nil;
local u4 = nil;
local u5 = nil;
local LocalPlayer = game.Players.LocalPlayer;

return function(u6) -- Line: 19, Name: Quickstep
    -- upvalues: LocalPlayer (copy), u1 (ref), u3 (ref), u2 (ref), u4 (ref), u5 (ref), Effects (copy), Essentials (copy), RunService (copy), ReplicatedStorage (copy)
    local Character = LocalPlayer.Character;
    local HumanoidRootPart = Character.HumanoidRootPart;
    local Humanoid = Character.Humanoid;
    u1 = u6.AbilityService;
    u3 = u6.Animations;
    u2 = u6.MovementController;
    u4 = u6.BallController;
    u5 = u6.CameraController;

    if u2.States.PumpFake then
        u6:ResetCD(2);
        Effects:Popup("Can\'t use after a fake!");

        return;
    end;

    u2.States.Ability = true;
    u2.Boost = 15;
    u6.AC:Add(task.delay(0.6, function() -- Line: 36
        -- upvalues: u2 (ref)
        u2.States.Ability = false;
        u2.Boost = 0;
    end));
    u6.AC:Add(function() -- Line: 42
        -- upvalues: u2 (ref)
        u2.States.Ability = false;
        u2.Boost = 0;
    end);
    u6.AC:Add(task.delay(1, function() -- Line: 48
        -- upvalues: u6 (copy)
        u6.AC:Clean();
    end));
    local v7 = u6:CheckInfront(20);
    u3:StopAll();
    u3:PlayChar("Flash", `Ability2{Essentials:ReturnRorL(u6.Network.CharValues)}`, Enum.AnimationPriority.Action3);
    u3:PlayBall("Flash", `Ability2{Essentials:ReturnRorL(u6.Network.CharValues)}Ball`, Enum.AnimationPriority.Action3);
    u1.Ability:Fire("QuickStep", {
        TimeSent = workspace:GetServerTimeNow(),
        Other = v7
    });
    u6.AC:Connect(u1.Ability, function() -- Line: 61
        -- upvalues: u6 (copy), u3 (ref), Essentials (ref), u2 (ref), RunService (ref), Humanoid (copy), ReplicatedStorage (ref), u4 (ref), LocalPlayer (ref), HumanoidRootPart (copy)
        u6.AC:Clean();
        u3:StopAll();
        u3:PlayChar("Flash", `Ability2Layup{Essentials:ReturnRorL(u6.Network.CharValues)}`, Enum.AnimationPriority.Action3);
        u3:PlayBall("Flash", `Ability2Layup{Essentials:ReturnRorL(u6.Network.CharValues)}Ball`, Enum.AnimationPriority.Action3);
        task.delay(0.5, function() -- Line: 68
            -- upvalues: u2 (ref), RunService (ref), Humanoid (ref)
            u2.States.Dunking = true;
            RunService.Heartbeat:Wait();
            Humanoid:ChangeState(Enum.HumanoidStateType.Jumping);
        end);
        task.wait(0.85);
        local Value = ReplicatedStorage.Basketball.Value;
        u2.States.Ability = false;
        u2.States.Dunking = false;
        u2.Boost = 0;
        Value.CFrame = u4:GetLastCharacterToPossessBall().PlrBall.Anims.BALL.CFrame;
        local Position = Value.Position;
        local _ = (workspace.Hoops[LocalPlayer.Team.Name].Hoop.Position - Position).Magnitude;
        local v8 = workspace.Hoops[LocalPlayer.Team.Name].Hoop.Position - Position;
        local math_log_ret = math.log(1 + v8.Magnitude * 0.045);
        local v9 = v8 / math_log_ret + Vector3.new(0, workspace.Gravity * math_log_ret * 0.5, 0);
        local _ = workspace.Hoops[LocalPlayer.Team.Name].Hoop.Position - HumanoidRootPart.Position;
        Value.AssemblyLinearVelocity = v9;
    end);
end;