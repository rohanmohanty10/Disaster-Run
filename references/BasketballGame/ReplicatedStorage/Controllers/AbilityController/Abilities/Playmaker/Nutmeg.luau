 
 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("Players");
game:GetService("TweenService");
local RunService = game:GetService("RunService");
require(ReplicatedStorage.Packages.Knit);
require(ReplicatedStorage.Shared.Utility.CameraShaker);
local Effects = require(ReplicatedStorage.Shared.Utility.Effects);
local Essentials = require(ReplicatedStorage.Shared.Utility.Essentials);
local u1 = nil;
local u2 = nil;
local u3 = nil;
local u4 = nil;
local LocalPlayer = game.Players.LocalPlayer;
RunService:IsStudio();

return function(u5) -- Line: 22, Name: Nutmeg
    -- upvalues: LocalPlayer (copy), Effects (copy), u2 (ref), u4 (ref), u1 (ref), u3 (ref), Essentials (copy), ReplicatedStorage (copy)
    local HumanoidRootPart = LocalPlayer.Character.HumanoidRootPart;
    local u6 = u5:CheckInfront(25);

    if not u6 then
        u5:ResetCD(1);
        Effects:Popup("Someone must be infront of you!");

        return;
    end;

    u2 = u5.MovementController;
    u4 = u5.BallController;
    u1 = u5.AbilityService;
    u3 = u5.Animations;

    if u2.States.PumpFake then
        u5:ResetCD(1);
        Effects:Popup("Can\'t use ability after fake!");

        return;
    end;

    u2.States.Ability = true;
    u2.Boost = 22;
    u5.AC:Add(task.delay(1, function() -- Line: 40
        -- upvalues: u2 (ref)
        u2.States.Ability = false;
        u2.Boost = 0;
    end));
    u5.AC:Add(task.delay(1.5, function() -- Line: 46
        -- upvalues: u5 (copy)
        u5.AC:Clean();
    end));
    u3:StopAll();
    u3:PlayChar("Playmaker", `Nutmeg{Essentials:ReturnRorL(u5.Network.CharValues)}`, Enum.AnimationPriority.Action3);
    u3:PlayBall("Playmaker", `Nutmeg{Essentials:ReturnRorL(u5.Network.CharValues)}Ball`, Enum.AnimationPriority.Action3);
    u1.Ability:Fire("Nutmeg", {
        TimeSent = workspace:GetServerTimeNow(),
        Other = u6
    });
    local u7 = (u6.HumanoidRootPart.Position - HumanoidRootPart.Position).Unit / 2 + HumanoidRootPart.CFrame.LookVector;
    local Magnitude = (u6.HumanoidRootPart.Position - HumanoidRootPart.Position).Magnitude;
    u5.AC:Connect(u1.Ability, function() -- Line: 59
        -- upvalues: u5 (copy), ReplicatedStorage (ref), u2 (ref), u4 (ref), u6 (copy), u7 (copy), Magnitude (copy), HumanoidRootPart (copy)
        u5.AC:Clean();
        local Value = ReplicatedStorage.Basketball.Value;
        task.delay(0.8, function() -- Line: 63
            -- upvalues: u2 (ref)
            u2.States.Ability = false;
            u2.Boost = 0;
        end);
        Value.CFrame = u4:GetLastCharacterToPossessBall().PlrBall.Anims.BALL.CFrame;
        Value.AssemblyLinearVelocity = ((u6.HumanoidRootPart.Position + u7 * (Magnitude * 7) - HumanoidRootPart.Position).Unit - Vector3.new(0, 0.8, 0)) * 75;
    end);
end;