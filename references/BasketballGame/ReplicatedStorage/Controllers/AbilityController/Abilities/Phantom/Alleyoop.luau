 
 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("Players");
game:GetService("TweenService");
local RunService = game:GetService("RunService");
require(ReplicatedStorage.Packages.Knit);
require(ReplicatedStorage.Shared.Utility.CameraShaker);
local Effects = require(ReplicatedStorage.Shared.Utility.Effects);
require(ReplicatedStorage.Shared.Utility.Essentials);
local u1 = nil;
local u2 = nil;
local u3 = nil;
local u4 = nil;
local u5 = nil;
local LocalPlayer = game.Players.LocalPlayer;

return function(u6) -- Line: 21
    -- upvalues: LocalPlayer (copy), Effects (copy), u4 (ref), u1 (ref), u3 (ref), u2 (ref), u5 (ref), ReplicatedStorage (copy), RunService (copy)
    if #LocalPlayer.Team:GetPlayers() < 2 then
        Effects:Popup("Need close team-mates to use ability!");
        u6:ResetCD(1);
        u6.AC:Clean();

        return;
    end;

    u4 = u6.BallController;
    u1 = u6.AbilityService;
    u3 = u6.Animations;
    u2 = u6.MovementController;
    u5 = u6.CameraController;
    local u7 = nil;
    local Hoop = workspace.Hoops[LocalPlayer.Team.Name].Hoop;

    if (Hoop.Position - LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 110 then
        u6:ResetCD(1);

        return;
    end;

    for _, v in LocalPlayer.Team:GetPlayers() do
        if v.Character and (v.Character:FindFirstChild("HumanoidRootPart") and (v ~= LocalPlayer and (Hoop.Position - v.Character.HumanoidRootPart.Position).Magnitude < 65)) then
            u7 = v.Character;
            break;
        end;
    end;

    if u7 == nil then
        Effects:Popup("Need close team-mates to use ability!");
        u6:ResetCD(1);
        u6.AC:Clean();

        return;
    end;

    u2.States.Ability = true;
    task.delay(0.75, function() -- Line: 52
        -- upvalues: u2 (ref)
        u2.States.Ability = false;
    end);
    u3:StopAll();
    u1.Ability:Fire("Alleyoop", {
        TimeSent = workspace:GetServerTimeNow(),
        Other = u7
    });
    u6.AC:Connect(u1.Ability, function() -- Line: 60
        -- upvalues: u2 (ref), ReplicatedStorage (ref), u4 (ref), u7 (ref), u6 (copy), RunService (ref)
        u2.States.Ability = false;
        local Value = ReplicatedStorage.Basketball.Value;
        Value.CFrame = u4:GetLastCharacterToPossessBall().PlrBall.Anims.BALL.CFrame;
        local Unit = (u7.HumanoidRootPart.Position - Value.Position).Unit;
        local _ = (u7.HumanoidRootPart.Position - Value.Position).Magnitude;
        local Position = Value.Position;
        local Position2 = u7.HumanoidRootPart.Position;
        local Magnitude = (Position2 - Position).Magnitude;
        Value.AssemblyLinearVelocity = (Unit + Vector3.new(0, 0.62, 0)) * Magnitude;
        local LinearVelocity = Instance.new("LinearVelocity");
        LinearVelocity.Attachment0 = Value.Root;
        LinearVelocity.MaxForce = 40000;
        LinearVelocity.VectorVelocity = (Unit + Vector3.new(0, 0.62, 0)) * Magnitude;
        u6.AC:Add(LinearVelocity);
        task.delay(0.05, function() -- Line: 86
            -- upvalues: LinearVelocity (copy), Value (copy), Magnitude (ref), u6 (ref), RunService (ref), u7 (ref), Position (ref), u4 (ref), Position2 (ref)
            LinearVelocity.Parent = Value;
            local u8 = tick();
            local u9 = 200;
            u6.AC:Connect(RunService.Heartbeat, function(p10) -- Line: 91
                -- upvalues: u7 (ref), Position (ref), u4 (ref), Position2 (ref), Magnitude (ref), u8 (copy), u6 (ref), Value (ref), LinearVelocity (ref), u9 (ref)
                if u7 == nil then
                    return;
                end;

                if not u7:FindFirstChild("HumanoidRootPart") then
                    return;
                end;

                Position = u4:GetServerBallPosition();
                Position2 = u7.HumanoidRootPart.Position;
                Magnitude = (Position2 - Position).Magnitude;

                if u8 + 1 >= tick() and not u4:GetPlayerPossessingBall() then
                    LinearVelocity.VectorVelocity = ((u7.HumanoidRootPart.Position - Position).Unit + Vector3.new(0, 0.35, 0)) * (u9 * 1.15);

                    return;
                end;

                u6.AC:Clean();
                Value.AssemblyLinearVelocity = LinearVelocity.VectorVelocity;
            end);
        end);
    end);
end;