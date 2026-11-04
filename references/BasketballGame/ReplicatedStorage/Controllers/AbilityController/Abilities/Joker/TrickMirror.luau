 
 

local Players = game:GetService("Players");
game:GetService("RunService");
local u1 = nil;
local LocalPlayer = Players.LocalPlayer;

return function(p2) -- Line: 8
    -- upvalues: u1 (ref), LocalPlayer (copy)
    u1 = p2.AbilityService;
    local _ = LocalPlayer.Character.HumanoidRootPart;
    u1.Ability:Fire("Trick Mirror", {
        TimeSent = workspace:GetServerTimeNow()
    });
end;