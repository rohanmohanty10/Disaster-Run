  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("ServerScriptService");
game:GetService("Players");
game:GetService("RunService");
game:GetService("TweenService");
game:GetService("RunService");
game:GetService("TweenService");
game:GetService("Debris");
require(ReplicatedStorage.Shared.Essentials);
require(ReplicatedStorage.Shared.Trove);
require(ReplicatedStorage.Shared.SoundManager);
require(ReplicatedStorage.Shared.Popup);
require(ReplicatedStorage.Shared.VfxManager);
local script_OffensiveDash = require(script.OffensiveDash);
local RivalsReactionClient = require(script.Parent.RivalsReactionClient);

return function(p1, p2, p3, p4) -- Line: 20, Name: NelIsagiBMove
    -- upvalues: RivalsReactionClient (copy), script_OffensiveDash (copy)
    if p3:GetAttribute("RivalsClash") then
        RivalsReactionClient(p1, p2, p3, "Isagi");

        return;
    end;

    if p1.AbilityThree > tick() then
        return;
    end;

    if p1.AbilityUsed > tick() then
        return;
    end;

    if p2.Character.Humanoid:GetState() == Enum.HumanoidStateType.Freefall then
        return;
    end;

    if not p2.Character.IsRagdoll.Value then
        return script_OffensiveDash(p1, p2, p3);
    end;
end;