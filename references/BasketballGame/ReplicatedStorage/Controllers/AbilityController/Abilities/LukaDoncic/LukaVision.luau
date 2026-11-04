 
 

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local RunService = game:GetService("RunService");
require(ReplicatedStorage.Packages.Knit);
require(ReplicatedStorage.Shared.Utility.CameraShaker);
local Effects = require(ReplicatedStorage.Shared.Utility.Effects);
local Essentials = require(ReplicatedStorage.Shared.Utility.Essentials);
local u1 = nil;
local u2 = nil;
local u3 = nil;
local u4 = nil;
local LocalPlayer = Players.LocalPlayer;

return function(u5) -- Line: 17
    -- upvalues: u1 (ref), u2 (ref), u3 (ref), u4 (ref), LocalPlayer (copy), RunService (copy), Effects (copy), Essentials (copy)
    u1 = u5.AbilityService;
    u2 = u5.Animations;
    u3 = u5.MovementController;
    u4 = u5.BallController;
    local HumanoidRootPart = LocalPlayer.Character.HumanoidRootPart;
    local v6;

    if RunService:IsStudio() then
        v6 = workspace.DefenseRig;
    else
        v6 = u4:GetCharacterPossessingBall();
        local PlayerPossessingBall = u4:GetPlayerPossessingBall();

        if not v6 then
            u5:ResetCD(3);
            Effects:Popup("Ball must be on enemy player!");

            return;
        end;

        if not PlayerPossessingBall then
            u5:ResetCD(3);
            Effects:Popup("Ball must be on enemy player!");

            return;
        end;

        if PlayerPossessingBall.Team == LocalPlayer.Team then
            u5:ResetCD(3);
            Effects:Popup("Ball must be on enemy player!");

            return;
        end;

        if v6.Humanoid:GetState() == Enum.HumanoidStateType.Jumping or v6.Humanoid:GetState() == Enum.HumanoidStateType.Freefall then
            u5:ResetCD(3);
            Effects:Popup("Enemy player must be on the ground!");

            return;
        end;

        local v7 = v6.HumanoidRootPart.Position.X - workspace.Hoops[Essentials:ActualTeam(LocalPlayer.Team.Name)].Hoop.Position.X;

        if math.abs(v7) > 145 then
            u5:ResetCD(3);
            Effects:Popup("Only usable on your side of the court!");

            return;
        end;

        if (v6.HumanoidRootPart.Position - HumanoidRootPart.Position).Magnitude > 70 then
            u5:ResetCD(3);
            Effects:Popup("Enemy player too far away!");

            return;
        end;
    end;

    u3.States.Ability = true;
    u3.States.NoWalk = true;
    task.delay(12.967, function() -- Line: 73
        -- upvalues: u3 (ref), RunService (ref), u5 (copy), Effects (ref)
        u3.States.Ability = false;
        u3.States.NoWalk = false;
        u3.Boost = 10;
        local u8 = nil;
        u8 = RunService.Heartbeat:Connect(function() -- Line: 79
            -- upvalues: u3 (ref), u5 (ref), u8 (ref)
            u3.Boost = 10;

            if not u5.Network.CharValues.InAwakening then
                u8:Disconnect();
                u8 = nil;
                u3.Boost = 0;
            end;
        end);
        Effects:Popup("LUKA VISION WEARS OFF IN 30 SECONDS.", 2, Color3.new(1, 0.941176, 0.121569));
        Effects:Popup("YOUR PASSES ARE ALWAYS PERFECT.", 2, Color3.new(0.0980392, 1, 0.411765));
        task.delay(25, function() -- Line: 91
            -- upvalues: u8 (ref), Effects (ref), u3 (ref)
            if u8 then
                u8:Disconnect();
                u8 = nil;

                for i = 1, 4 do
                    task.wait(1);
                    Effects:Popup((`LUKA VISION WEARING OFF IN {5 - i}`));
                    local _ = i;
                end;

                u3.Boost = 0;
            end;
        end);
    end);
    u2:StopAll();
    u1.Ability:Fire("Luka Vision", {
        TimeSent = workspace:GetServerTimeNow(),
        Other = v6
    });
end;