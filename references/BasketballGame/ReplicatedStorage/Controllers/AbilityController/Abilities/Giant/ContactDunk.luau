 
 

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
local LocalPlayer = game.Players.LocalPlayer;

return function(p5) -- Line: 22, Name: ContactDunk
    -- upvalues: LocalPlayer (copy), Effects (copy), RunService (copy), u1 (ref), u3 (ref), u2 (ref), u4 (ref)
    local HumanoidRootPart = LocalPlayer.Character.HumanoidRootPart;
    local Attribute = LocalPlayer:GetAttribute("TrueGiant");
    local Hoop = workspace.Hoops[LocalPlayer.Team.Name].Hoop;
    local Vector3_new_ret = Vector3.new(Hoop.Position.X, HumanoidRootPart.Position.Y, Hoop.Position.Z);
    local Magnitude = (HumanoidRootPart.Position - Vector3_new_ret).Magnitude;

    if not Attribute and Magnitude <= 30 then
        p5:ResetCD(4);
        Effects:Popup("Too close to Hoop!");

        return;
    end;

    if not Attribute and Magnitude >= 80 then
        p5:ResetCD(4);
        Effects:Popup("Too far away from hoop!");

        return;
    end;

    local v6 = p5:CheckInfront(30);

    if v6 == nil and RunService:IsStudio() then
        v6 = workspace.DefenseRig;
    end;

    if not (Attribute or v6) then
        p5:ResetCD(4);
        Effects:Popup("Someone must be infront of you!");

        return;
    end;

    u1 = p5.AbilityService;
    u3 = p5.Animations;
    u2 = p5.MovementController;
    u4 = p5.Network;
    u2.States.Ability = true;
    u2.States.Dunking = true;
    u2.States.NoWalk = true;
    task.delay(1.5, function() -- Line: 48
        -- upvalues: u2 (ref)
        u2.States.Ability = false;
        u2.States.NoWalk = false;
        u2.States.Dunking = false;
    end);
    u3:StopAll();
    u3:PlayChar("Giant", "Ability4", Enum.AnimationPriority.Action4);
    u3:PlayBall("Giant", "Ability4Ball", Enum.AnimationPriority.Action4);
    u1.Ability:Fire("ContactDunk", {
        TimeSent = workspace:GetServerTimeNow(),
        Other = v6
    });
end;