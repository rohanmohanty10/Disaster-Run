 
 

game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("TweenService");
local RunService = game:GetService("RunService");
require(ReplicatedStorage.Packages.Knit);
require(ReplicatedStorage.Shared.Utility.CameraShaker);
local Effects = require(ReplicatedStorage.Shared.Utility.Effects);
local Essentials = require(ReplicatedStorage.Shared.Utility.Essentials);
require(ReplicatedStorage.Shared.Functions.CalculateBallTrajectory);
local _ = require(ReplicatedStorage.Shared.Tables.Cooldowns).Abilities;
local u1 = nil;
local u2 = nil;
local u3 = nil;
local u4 = nil;
local u5 = nil;
local u6 = nil;
local LocalPlayer = game.Players.LocalPlayer;

return function(u7) -- Line: 22
    -- upvalues: LocalPlayer (copy), u1 (ref), u2 (ref), u3 (ref), u4 (ref), u5 (ref), u6 (ref), Effects (copy), Essentials (copy), ReplicatedStorage (copy), RunService (copy)
    local Character = LocalPlayer.Character;
    local HumanoidRootPart = Character.HumanoidRootPart;
    local _ = Character.Humanoid;
    u1 = u7.AbilityService;
    u2 = u7.MovementController;
    u3 = u7.CameraController;
    u4 = u7.BallController;
    u5 = u7.Animations;
    u6 = u7.Network;
    local PlayerPossessingBall = u4:GetPlayerPossessingBall();

    if not PlayerPossessingBall then
        Effects:Popup("Someone must have the ball!");
        u7:ResetCD(4);

        return;
    end;

    if not u4:LocalPlayerIsWithinDistanceOfBall(100) then
        u7:ResetCD(4);
        Effects:Popup("Must be close to the ball!");

        return;
    end;

    if PlayerPossessingBall.Team == LocalPlayer.Team then
        u1.Ability:Fire("Death Painting", {
            TimeSent = workspace:GetServerTimeNow()
        });
        u7.AC:Connect(u1.Ability, function(p8) -- Line: 73
            -- upvalues: u7 (copy), Effects (ref), ReplicatedStorage (ref), HumanoidRootPart (copy), RunService (ref), u4 (ref), Character (copy)
            u7.AC:Clean();

            if p8 then
                u7:ResetCD(4);
                Effects:Popup("Ball is on iframes!");

                return;
            end;

            local Value = ReplicatedStorage.Basketball.Value;
            local Unit = (HumanoidRootPart.Position - Value.Position).Unit;
            local _ = (HumanoidRootPart.Position - Value.Position).Magnitude;
            local Magnitude = (HumanoidRootPart.Position - Value.Position).Magnitude;
            Value.AssemblyLinearVelocity = (Unit + Vector3.new(0, 0.62, 0)) * Magnitude;
            local LinearVelocity = Instance.new("LinearVelocity");
            LinearVelocity.Attachment0 = Value.Root;
            LinearVelocity.MaxForce = 40000;
            LinearVelocity.VectorVelocity = (Unit + Vector3.new(0, 0.62, 0)) * Magnitude;
            u7.AC:Add(LinearVelocity);
            u7.AC:Add(task.delay(0.15, function() -- Line: 102
                -- upvalues: LinearVelocity (copy), Value (copy), u7 (ref), RunService (ref), u4 (ref), Character (ref)
                LinearVelocity.Parent = Value;
                local u9 = tick();
                local u10 = false;
                u7.AC:Connect(RunService.Heartbeat, function(p11) -- Line: 108
                    -- upvalues: u4 (ref), u7 (ref), u10 (ref), u9 (copy), Value (ref), LinearVelocity (ref), Character (ref)
                    if not u4:LocalPlayerIsBallNetworkOwner() then
                        u7.AC:Clean();

                        return;
                    end;

                    local v12 = -u4:GetVectorOffsetBetweenLocalPlayerAndBall(true);
                    local v13 = v12:Dot(v12);

                    if v13 >= 400 then
                        u10 = true;
                    end;

                    local CharacterPossessingBall = u4:GetCharacterPossessingBall();

                    if u9 + 3 < tick() or (Value.Parent == nil or (CharacterPossessingBall or u10 and v13 <= 144)) or v13 <= 100 then
                        u7.AC:Clean();
                        Value.AssemblyLinearVelocity = LinearVelocity.VectorVelocity;

                        return;
                    end;

                    if CharacterPossessingBall == Character then
                        LinearVelocity.Parent = nil;
                    end;

                    LinearVelocity.Parent = Value;
                    LinearVelocity.VectorVelocity = v12.Unit * 250;
                end);
            end));
        end);

        return;
    end;

    if PlayerPossessingBall.Character.Humanoid:GetState() == Enum.HumanoidStateType.Jumping or PlayerPossessingBall.Character.Humanoid:GetState() == Enum.HumanoidStateType.Freefall then
        u7:ResetCD(4);
        Effects:Popup("Enemy player must be on the ground!");

        return;
    end;

    local v14 = PlayerPossessingBall.Character.HumanoidRootPart.Position.X - workspace.Hoops[Essentials:ActualTeam(LocalPlayer.Team.Name)].Hoop.Position.X;

    if math.abs(v14) > 145 then
        u7:ResetCD(4);
        Effects:Popup("Only usable on your side of the court!");

        return;
    end;

    u2.States.Ability = true;
    u2.States.NoWalk = true;
    task.delay(14.5, function() -- Line: 63
        -- upvalues: u2 (ref)
        u2.States.Ability = false;
        u2.States.NoWalk = false;
    end);
    u5:StopAll();
    u1.Ability:Fire("Death Painting", {
        Enemy = true,
        TimeSent = workspace:GetServerTimeNow(),
        Other = PlayerPossessingBall.Character
    });
end;