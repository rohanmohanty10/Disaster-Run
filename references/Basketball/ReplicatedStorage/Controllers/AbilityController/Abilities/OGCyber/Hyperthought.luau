 
 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("Players");
game:GetService("TweenService");
game:GetService("RunService");
require(ReplicatedStorage.Packages.Knit);
require(ReplicatedStorage.Shared.Utility.CameraShaker);
require(ReplicatedStorage.Shared.Utility.Effects);
local u1 = nil;
local u2 = nil;
local u3 = nil;
local u4 = nil;
local u5 = nil;
local LocalPlayer = game.Players.LocalPlayer;

return function(p6) -- Line: 22, Name: Hyperthought
    -- upvalues: LocalPlayer (copy), u2 (ref), u4 (ref), u1 (ref), u3 (ref), u5 (ref)
    local HumanoidRootPart = LocalPlayer.Character.HumanoidRootPart;
    u2 = p6.MovementController;
    u4 = p6.BallController;
    u1 = p6.AbilityService;
    u3 = p6.Animations;
    u5 = p6.Network;
    local v7 = (workspace.Hoops[LocalPlayer.Team.Name].Hoop.Position - HumanoidRootPart.Position).Magnitude <= 120;

    if not u5.CharValues.HasBall then
        local LastPlayerToPossessBall = u4:GetLastPlayerToPossessBall();
        local LastCharacterToPossessBall = u4:GetLastCharacterToPossessBall();

        if LastCharacterToPossessBall == nil then
            v7 = false;
        end;

        if LastPlayerToPossessBall.Team == LocalPlayer.Team then
            v7 = false;
        end;

        if (LastCharacterToPossessBall.HumanoidRootPart.Position - HumanoidRootPart.Position).Magnitude > 50 then
            v7 = false;
        end;
    end;

    if v7 then
        task.delay(21.25, function() -- Line: 76
            -- upvalues: u2 (ref)
            u2.States.Ability = false;
            u2.States.NoWalk = false;
        end);
        u3:StopAll();
        u1.Ability:Fire("OGHyperthought", {
            TimeSent = workspace:GetServerTimeNow()
        });

        return;
    end;

    u2.States.Ability = true;
    u1.Ability:Fire("Hyperthought", {
        NoCutscene = true,
        TimeSent = workspace:GetServerTimeNow()
    });
    local v8 = u2;
    v8.Boost = v8.Boost + 10;
    task.delay(5, function() -- Line: 63
        -- upvalues: u2 (ref)
        u2.States.Ability = false;
        local v9 = u2;
        v9.Boost = v9.Boost - 10;

        if u2.Boost < 0 then
            u2.Boost = 0;
        end;
    end);
end;