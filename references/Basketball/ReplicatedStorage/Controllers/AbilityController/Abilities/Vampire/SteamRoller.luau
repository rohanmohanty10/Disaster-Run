 
 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("Players");
game:GetService("TweenService");
game:GetService("RunService");
require(ReplicatedStorage.Packages.Knit);
require(ReplicatedStorage.Shared.Utility.CameraShaker);
local Effects = require(ReplicatedStorage.Shared.Utility.Effects);
local u1 = nil;
local u2 = nil;
local u3 = nil;
local u4 = nil;
local LocalPlayer = game.Players.LocalPlayer;

return function(u5) -- Line: 22, Name: TimeStop
    -- upvalues: LocalPlayer (copy), u1 (ref), u3 (ref), u2 (ref), u4 (ref), Effects (copy)
    local _ = LocalPlayer.Character.HumanoidRootPart;
    u1 = u5.AbilityService;
    u3 = u5.Animations;
    u2 = u5.MovementController;
    u4 = u5.Network;
    local v6 = u5:CheckInfront(50);

    if not v6 then
        Effects:Popup("An enemy must be infront of you!");

        return u5:ResetCD(4);
    end;

    local v7 = { "BodyVelocity", "LinearVelocity", "AlignOrientation", "AlignPosition" };
    local v8 = { "Declaration" };

    if v6.Humanoid:GetState() == Enum.HumanoidStateType.Freefall then
        Effects:Popup("Enemy must be on the ground to use");

        return u5:ResetCD(4);
    end;

    for _, descendant in v6:GetDescendants() do
        if table.find(v7, descendant.ClassName) or table.find(v8, descendant.Name) then
            Effects:Popup("Can\'t hit enemy in ability.");

            return u5:ResetCD(4);
        end;
    end;

    if v6:FindFirstChild("IsRagdoll") and v6.IsRagdoll.Value then
        Effects:Popup("Enemy must not be ragdolled!");

        return u5:ResetCD(4);
    end;

    u2.States.Ability = true;
    u2.States.NoWalk = true;
    u5.AC:Add(task.delay(3.3833333333333333, function() -- Line: 61
        -- upvalues: u2 (ref), u5 (copy)
        u2.States.Ability = false;
        u2.States.NoWalk = false;
        u5.AC:Clean();
    end));
    u3:StopAll();
    u3:PlayChar("Vampire", "SteamRoller", Enum.AnimationPriority.Action3);
    u1.Ability:Fire("VampireSteamRoller", {
        TimeSent = workspace:GetServerTimeNow(),
        Target = v6
    });
    u5.AC:Connect(u1.Ability, function() -- Line: 71
        -- upvalues: u5 (copy), u3 (ref), u2 (ref)
        u5.AC:Clean();
        u3:StopAll();
        u2.States.Ability = false;
        u2.States.NoWalk = false;
    end);
end;