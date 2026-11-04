 
 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("Players");
game:GetService("TweenService");
local RunService = game:GetService("RunService");
require(ReplicatedStorage.Packages.Knit);
local CameraShaker = require(ReplicatedStorage.Shared.Utility.CameraShaker);
local Effects = require(ReplicatedStorage.Shared.Utility.Effects);
local u1 = nil;
local u2 = nil;
local u3 = nil;
local u4 = nil;
local u5 = nil;
local LocalPlayer = game.Players.LocalPlayer;

return function(u6) -- Line: 18, Name: Intercept
    -- upvalues: LocalPlayer (copy), u2 (ref), u5 (ref), u4 (ref), u1 (ref), u3 (ref), Effects (copy), CameraShaker (copy), ReplicatedStorage (copy), RunService (copy)
    local Character = LocalPlayer.Character;
    local HumanoidRootPart = Character.HumanoidRootPart;
    local _ = Character.Humanoid;
    u2 = u6.MovementController;
    u5 = u6.CameraController;
    u4 = u6.BallController;
    u1 = u6.AbilityService;
    u3 = u6.Animations;
    local LastPlayerToPossessBall = u4:GetLastPlayerToPossessBall();

    if LastPlayerToPossessBall == nil or LastPlayerToPossessBall.Team == LocalPlayer.Team then
        u6:ResetCD(1);
        Effects:Popup("Ball must have been just passed by enemy player!");

        return;
    end;

    local Character2 = LastPlayerToPossessBall.Character;

    if Character2 == nil then
        u6:ResetCD(1);
        Effects:Popup("Ball must be passed!");

        return;
    end;

    if Character2 == Character then
        u6:ResetCD(1);
        Effects:Popup("Ball must have been just passed by enemy player!");

        return;
    end;

    if Character2:GetAttribute("Unblockable") and Character2:GetAttribute("Unblockable") > workspace:GetServerTimeNow() then
        u6:ResetCD(1);
        Effects:Popup("Can\'t block pass!");

        return;
    end;

    if u4:GetPlayerPossessingBall() then
        u6:ResetCD(1);
        Effects:Popup("Ball must have been just passed!");

        return;
    end;

    if (u4:GetServerBallPosition() - HumanoidRootPart.Position).Magnitude >= 50 then
        u6:ResetCD(1);
        Effects:Popup("Ball is too far away!");

        return;
    end;

    u2.States.Ability = true;
    u6.AC:Add(task.delay(1, function() -- Line: 83
        -- upvalues: u2 (ref)
        u2.States.Ability = false;
    end));
    u6.AC:Connect(u1.Ability, function(p7) -- Line: 87
        -- upvalues: u6 (copy), Effects (ref), u2 (ref), u3 (ref), LocalPlayer (ref), u4 (ref), Character (copy), HumanoidRootPart (copy), u5 (ref), CameraShaker (ref), ReplicatedStorage (ref), RunService (ref)
        if p7.Fail then
            u6.AC:Clean();
            Effects:Popup("Ball must just have been passed!");
            u6.CDS[1] = tick() + 1;
            u2.States.Ability = false;

            return;
        end;

        u6:ResetCopy();
        u2.States.Ability = true;
        u2.States.NoWalk = true;
        u3:StopAll();
        local v8 = u3:PlayChar("Lock", "InterceptStart", Enum.AnimationPriority.Action3, true);
        local v9 = u3:PlayBall("Lock", "InterceptStartBall", Enum.AnimationPriority.Action3, true);
        local v10 = workspace:GetServerTimeNow() - p7[1];
        v8.TimePosition = v10;
        v9.TimePosition = v10;

        if #LocalPlayer.Team:GetPlayers() < 2 then
            task.delay(1 - v10, function() -- Line: 219
                -- upvalues: u2 (ref)
                u2.States.Ability = false;
                u2.States.NoWalk = false;
            end);

            return;
        end;

        task.delay(0.95 - v10, function() -- Line: 111
            -- upvalues: u3 (ref)
            u3:StopAll();
            u3:PlayChar("Lock", "InterceptPass", Enum.AnimationPriority.Action3);
            u3:PlayBall("Lock", "InterceptPassBall", Enum.AnimationPriority.Action3);
        end);
        task.delay(1.5 - v10, function() -- Line: 117
            -- upvalues: u4 (ref), Character (ref), u6 (ref), LocalPlayer (ref), HumanoidRootPart (ref), u5 (ref), CameraShaker (ref), ReplicatedStorage (ref), RunService (ref)
            local v11 = tick();

            while not u4:LocalPlayerIsBallNetworkOwner() do
                if not Character.Parent or tick() - v11 > 3 then
                    return;
                end;

                task.wait();
            end;

            local LookingAt = u6.Pass.LookingAt;

            if not LookingAt then
                local v12 = 9999;
                LookingAt = nil;

                for _, v in LocalPlayer.Team:GetPlayers() do
                    if v ~= LocalPlayer and v.Character:FindFirstChild("HumanoidRootPart") then
                        local Magnitude = (v.Character.HumanoidRootPart.Position - HumanoidRootPart.Position).Magnitude;

                        if Magnitude < v12 then
                            LookingAt = v.Character;
                            v12 = Magnitude;
                        end;
                    end;
                end;
            end;

            u5.CamShake:Shake(CameraShaker.Presets.Dunk);
            local Value = ReplicatedStorage.Basketball.Value;
            Value.CFrame = u4:GetLastCharacterToPossessBall().PlrBall.Anims.BALL.CFrame;
            local Unit = (LookingAt.HumanoidRootPart.Position - Value.Position).Unit;
            local _ = (LookingAt.HumanoidRootPart.Position - Value.Position).Magnitude;
            local Position = Value.Position;
            local Position2 = LookingAt.HumanoidRootPart.Position;
            local Magnitude = (Position2 - Position).Magnitude;
            Value.AssemblyLinearVelocity = (Unit + Vector3.new(0, 0.62, 0)) * Magnitude;
            local LinearVelocity = Instance.new("LinearVelocity");
            LinearVelocity.Attachment0 = Value.Root;
            LinearVelocity.MaxForce = 40000;
            LinearVelocity.VectorVelocity = (Unit + Vector3.new(0, 0.62, 0)) * Magnitude;
            u6.AC:Add(LinearVelocity);
            u6.AC:Add(task.delay(0.15, function() -- Line: 166
                -- upvalues: LinearVelocity (copy), Value (copy), Magnitude (ref), u6 (ref), RunService (ref), Position (ref), u4 (ref), Position2 (ref), LookingAt (copy), HumanoidRootPart (ref), Character (ref)
                LinearVelocity.Parent = Value;
                local u13 = tick();
                local u14 = false;
                local u15 = 75;
                u6.AC:Connect(RunService.Heartbeat, function(p16) -- Line: 172
                    -- upvalues: Position (ref), u4 (ref), Position2 (ref), LookingAt (ref), Magnitude (ref), HumanoidRootPart (ref), u14 (ref), u6 (ref), Value (ref), LinearVelocity (ref), u13 (copy), Character (ref), u15 (ref)
                    Position = u4:GetServerBallPosition();
                    Position2 = LookingAt.HumanoidRootPart.Position;
                    Magnitude = (Position2 - Position).Magnitude;
                    local Magnitude2 = (HumanoidRootPart.Position - Position).Magnitude;

                    if Magnitude2 >= 20 then
                        u14 = true;
                    end;

                    if Magnitude2 <= 12 and u14 then
                        u6.AC:Clean();
                        Value.AssemblyLinearVelocity = LinearVelocity.VectorVelocity;

                        return;
                    end;

                    if not u4:LocalPlayerIsBallNetworkOwner() then
                        u6.AC:Clean();

                        return;
                    end;

                    if not (LookingAt and (u13 + 1.5 >= tick() and (Magnitude > 10 or LookingAt.HumanoidRootPart ~= HumanoidRootPart)) and (Value.Parent ~= nil and (workspace:FindFirstChild(LookingAt.Name) and not u4:GetPlayerPossessingBall()))) then
                        u6.AC:Clean();
                        Value.AssemblyLinearVelocity = LinearVelocity.VectorVelocity;

                        return;
                    end;

                    if u4:CharacterPossessesBall(Character) then
                        LinearVelocity.Parent = nil;
                    end;

                    LinearVelocity.Parent = Value;
                    LinearVelocity.VectorVelocity = ((LookingAt.HumanoidRootPart.Position - Position).Unit + Vector3.new(0, 0, 0)) * (u15 * 1.8);
                end);
            end));
        end);
        task.delay(2 - v10, function() -- Line: 214
            -- upvalues: u2 (ref)
            u2.States.Ability = false;
            u2.States.NoWalk = false;
        end);
    end);
    u1.Ability:Fire("Intercept", {
        TimeSent = workspace:GetServerTimeNow()
    });
end;