 
 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("Players");
game:GetService("TweenService");
game:GetService("RunService");
require(ReplicatedStorage.Packages.Knit);
require(ReplicatedStorage.Shared.Utility.CameraShaker);
local Effects = require(ReplicatedStorage.Shared.Utility.Effects);
require(ReplicatedStorage.Shared.Utility.Essentials);
local u1 = nil;
local u2 = nil;
local u3 = nil;
local u4 = nil;
local LocalPlayer = game.Players.LocalPlayer;

return function(p5) -- Line: 22, Name: ReverseDunk
    -- upvalues: LocalPlayer (copy), Effects (copy), u1 (ref), u3 (ref), u2 (ref), u4 (ref)
    local HumanoidRootPart = LocalPlayer.Character.HumanoidRootPart;
    local Hoop = workspace.Hoops[LocalPlayer.Team.Name].Hoop;
    local Vector3_new_ret = Vector3.new(Hoop.Position.X, HumanoidRootPart.Position.Y, Hoop.Position.Z);
    local Magnitude = (HumanoidRootPart.Position - Vector3_new_ret).Magnitude;

    if Magnitude <= 30 then
        p5:ResetCD(1);
        Effects:Popup("Too close to Hoop!");

        return;
    end;

    if Magnitude >= 100 then
        p5:ResetCD(1);
        Effects:Popup("Too far away from hoop!");

        return;
    end;

    if p5.MovementController.States.PumpFake then
        p5:ResetCD(1);
        Effects:Popup("Can\'t use after a fake!");

        return;
    end;

    u1 = p5.AbilityService;
    u3 = p5.Animations;
    u2 = p5.MovementController;
    u4 = p5.Network;
    u2.States.Ability = true;
    u2.States.Dunking = true;
    u2.States.NoWalk = true;
    task.delay(1.5, function() -- Line: 41
        -- upvalues: u2 (ref)
        u2.States.Ability = false;
        u2.States.NoWalk = false;
        u2.States.Dunking = false;
    end);
    u3:StopAll();
    u3:PlayChar("BasketballGod", "ReverseDunk", Enum.AnimationPriority.Action3);
    u3:PlayBall("BasketballGod", "ReverseDunkBall", Enum.AnimationPriority.Action3);
    u1.Ability:Fire("ReverseDunk", {
        TimeSent = workspace:GetServerTimeNow()
    });
    p5.AC:Connect(p5.AbilityService.Ability, function() -- Line: 50
        -- upvalues: u3 (ref)
        u3:StopAll();
        local math_random_ret = math.random(1, 2);
        u3:PlayChar("BasketballGod", `ReverseDunk{tostring(math_random_ret)}`, Enum.AnimationPriority.Action3);
        u3:PlayBall("BasketballGod", `ReverseDunk{tostring(math_random_ret)}Ball`, Enum.AnimationPriority.Action3);
    end);
end;