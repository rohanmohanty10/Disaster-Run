 
 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("Players");
game:GetService("TweenService");
local RunService = game:GetService("RunService");
require(ReplicatedStorage.Packages.Knit);
require(ReplicatedStorage.Shared.Utility.CameraShaker);
local Effects = require(ReplicatedStorage.Shared.Utility.Effects);
local u1 = nil;
local u2 = nil;
local u3 = nil;
local u4 = nil;
local LocalPlayer = game.Players.LocalPlayer;

return function(u5) -- Line: 19, Name: AwakenAbility1
    -- upvalues: LocalPlayer (copy), u1 (ref), u3 (ref), u2 (ref), u4 (ref), Effects (copy), RunService (copy)
    local _ = LocalPlayer.Character.HumanoidRootPart;
    u1 = u5.AbilityService;
    u3 = u5.Animations;
    u2 = u5.MovementController;
    u4 = u5.BallController;
    u2.States.Ability = true;
    u2.States.NoWalk = true;
    u3:StopAll();
    u3:PlayChar("LazyWorker", "Cook", Enum.AnimationPriority.Action4);
    u1.Ability:Fire("Cook", {
        State = "Start",
        TimeSent = workspace:GetServerTimeNow()
    });
    local u6 = nil;

    local function DoChosenAbility(p7) -- Line: 37
        -- upvalues: u1 (ref), u3 (ref), u2 (ref), Effects (ref), RunService (ref)
        u1.Ability:Fire("Cook", {
            TimeSent = workspace:GetServerTimeNow(),
            State = p7
        });
        u3:StopAll();
        u3:PlayChar("LazyWorker", "CookEat", Enum.AnimationPriority.Action4);
        task.delay(1.0833333333333333, function() -- Line: 41
            -- upvalues: u2 (ref)
            u2.States.Ability = false;
            u2.States.NoWalk = false;
        end);

        if p7 ~= "Fries" then
            if p7 == "Burger" then
                Effects:Popup("BURGER! ANY NORMAL SHOT YOU MAKE IS 100% TO GO IN! (blockable, one time only)", 6);
            end;

            return;
        end;

        Effects:Popup("FRIES EATEN, SPEED INCREASED LETS GO", 6);
        local u9 = RunService.Heartbeat:Connect(function(p8) -- Line: 48
            -- upvalues: u2 (ref)
            u2.Boost = 5;
        end);
        task.delay(30, function() -- Line: 52
            -- upvalues: Effects (ref), u9 (ref), RunService (ref), u2 (ref)
            Effects:Popup("FRIES BOOST ENDED GGS");
            u9:Disconnect();
            RunService.Heartbeat:Wait();
            u2.Boost = 0;
        end);
    end;

    u5.AC:Connect(u1.Ability, function(p10) -- Line: 64
        -- upvalues: u5 (copy), u6 (ref), DoChosenAbility (copy)
        if p10.State == "CheckChosen" then
            u5.AC:Clean();
            u6 = p10.Food;
            DoChosenAbility(u6);
        end;
    end);
end;