 
 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("Players");
game:GetService("TweenService");
local RunService = game:GetService("RunService");
require(ReplicatedStorage.Packages.Knit);
require(ReplicatedStorage.Shared.Utility.CameraShaker);
local Effects = require(ReplicatedStorage.Shared.Utility.Effects);
local Essentials = require(ReplicatedStorage.Shared.Utility.Essentials);
require(ReplicatedStorage.Shared.Functions.CalculateBallTrajectory);
local u1 = nil;
local u2 = nil;
local u3 = nil;
local u4 = nil;
local u5 = nil;
local LocalPlayer = game.Players.LocalPlayer;

return function(u6) -- Line: 22, Name: Selfoop
    -- upvalues: LocalPlayer (copy), u5 (ref), Effects (copy), u1 (ref), u3 (ref), u2 (ref), u4 (ref), Essentials (copy), ReplicatedStorage (copy), RunService (copy)
    local HumanoidRootPart = LocalPlayer.Character.HumanoidRootPart;
    u5 = u6.Network;

    if (workspace.Hoops[LocalPlayer.Team.Name].Hoop.Position - HumanoidRootPart.Position).Magnitude >= 100 then
        u6:ResetCD(3);
        Effects:Popup("Too far away from hoop!", 1);

        return;
    end;

    if (workspace.Hoops[LocalPlayer.Team.Name].Hoop.Position - HumanoidRootPart.Position).Magnitude <= 40 then
        u6:ResetCD(3);
        Effects:Popup("Too close to hoop!", 1);

        return;
    end;

    if u6.MovementController.States.PumpFake then
        u6:ResetCD(3);
        Effects:Popup("Can\'t use move after fake!");

        return;
    end;

    u1 = u6.AbilityService;
    u3 = u6.Animations;
    u2 = u6.MovementController;
    u4 = u6.BallController;
    u2.States.Ability = true;
    task.delay(2, function() -- Line: 39
        -- upvalues: u2 (ref), u6 (copy)
        u2.States.Ability = false;
        u2.Boost = 0;
        u6.AC:Clean();
    end);
    u3:StopAll();
    u3:PlayChar("Star", `Ability3Pass{Essentials:ReturnRorL(u5.CharValues)}`, Enum.AnimationPriority.Action3);
    u3:PlayBall("Star", `Ability3Ball{Essentials:ReturnRorL(u5.CharValues)}`, Enum.AnimationPriority.Action3);
    u1.Ability:Fire("Selfoop", {
        TimeSent = workspace:GetServerTimeNow()
    });
    u6.AC:Connect(u1.Ability, function() -- Line: 52
        -- upvalues: ReplicatedStorage (ref), u4 (ref), LocalPlayer (ref), u6 (copy), HumanoidRootPart (copy), u3 (ref), RunService (ref), u5 (ref), u2 (ref)
        local Value = ReplicatedStorage.Basketball.Value;
        Value.CFrame = u4:GetLastCharacterToPossessBall().PlrBall.Anims.BALL.CFrame;
        local Position = workspace.Hoops[LocalPlayer.Team.Name].Hoop.Position;
        local Unit = (workspace.Hoops[LocalPlayer.Team.Name].Hoop.Position + Vector3.new(0, 16, 0) - Value.Position).Unit;
        local math_clamp_ret = math.clamp((workspace.Hoops[LocalPlayer.Team.Name].Hoop.Position + Vector3.new(0, 16, 0) - Value.Position).Magnitude * 2, 120, 200);
        Value.AssemblyLinearVelocity = Unit * math_clamp_ret;
        local LinearVelocity = Instance.new("LinearVelocity");
        LinearVelocity.Attachment0 = Value.Root;
        LinearVelocity.MaxForce = 40000;
        LinearVelocity.VectorVelocity = Unit * (math_clamp_ret / 2.25);
        u6.AC:Add(LinearVelocity);
        local LinearVelocity2 = Instance.new("LinearVelocity");
        LinearVelocity2.Attachment0 = HumanoidRootPart.RootAttachment;
        LinearVelocity2.MaxForce = 40000;
        LinearVelocity2.VectorVelocity = (Vector3.new(Position.X, HumanoidRootPart.Position.Y, Position.Z) - HumanoidRootPart.Position).Unit * 50;
        LinearVelocity2.Parent = HumanoidRootPart;
        u6.AC:Add(LinearVelocity2);
        task.delay(0.12, function() -- Line: 83
            -- upvalues: u3 (ref), LocalPlayer (ref), u6 (ref), RunService (ref), u4 (ref), HumanoidRootPart (ref), Position (copy), u5 (ref), LinearVelocity (ref), math_clamp_ret (ref), LinearVelocity2 (ref), Value (copy), u2 (ref)
            u3:StopAll();
            u3:PlayChar("Star", "Ability2", Enum.AnimationPriority.Action3);
            local u7 = tick();
            local u8 = workspace.Hoops[LocalPlayer.Team.Name].Hoop.Position + Vector3.new(0, 5, 0);
            local u9 = false;
            u6.AC:Connect(RunService.Heartbeat, function() -- Line: 92
                -- upvalues: u4 (ref), u8 (copy), HumanoidRootPart (ref), Position (ref), u7 (copy), u6 (ref), u9 (ref), u5 (ref), LinearVelocity (ref), math_clamp_ret (ref), LinearVelocity2 (ref), Value (ref), u3 (ref), u2 (ref), RunService (ref)
                local ServerBallPosition = u4:GetServerBallPosition();
                local Magnitude = (ServerBallPosition - u8).Magnitude;
                local Magnitude2 = (HumanoidRootPart.Position * Vector3.new(1, 0, 1) - Position * Vector3.new(1, 0, 1)).Magnitude;

                if u7 + 1.5 < tick() then
                    u6.AC:Clean();

                    return;
                end;

                if Magnitude < 40 then
                    if u9 then
                        if u5.CharValues.HasBall or (ServerBallPosition - HumanoidRootPart.Position).Magnitude <= 0 then
                            if u5.CharValues.HasBall and LinearVelocity then
                                LinearVelocity:Destroy();
                                LinearVelocity = nil;
                            end;
                        else
                            LinearVelocity.VectorVelocity = (ServerBallPosition - HumanoidRootPart.Position).Unit * (math_clamp_ret / 2.25);
                        end;

                        if Magnitude2 < 25 and LinearVelocity2 then
                            LinearVelocity2:Destroy();
                            LinearVelocity2 = nil;
                        end;
                    elseif Magnitude < 5 then
                        u9 = true;
                        local v10 = Value;
                        v10.AssemblyLinearVelocity = v10.AssemblyLinearVelocity * Vector3.new(-1, 1, -1);
                        u3:StopAll();
                        u3:PlayChar("Blocks", "JumpBlock", Enum.AnimationPriority.Action3);
                        LinearVelocity2.VectorVelocity = (Position - (Position - HumanoidRootPart.Position).Unit * 15 + Vector3.new(0, 5, 0) - HumanoidRootPart.Position).Unit * 80;
                    else
                        LinearVelocity.VectorVelocity = (u8 - ServerBallPosition).Unit * (math_clamp_ret / 1.1);
                    end;
                end;

                if u5.CharValues.HasBall and (u9 and Magnitude2 <= 15) then
                    u6.AC:Clean();
                    u2.States.Ability = false;
                    u2.Boost = 0;
                    RunService.Heartbeat:Wait();
                    u4:Dunk(nil, nil, true);
                end;
            end);
        end);
    end);
end;