  

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
local script_DirectShot = require(script.DirectShot);

return function(p1, p2, p3, p4) -- Line: 19, Name: NelIsagiCMove
    -- upvalues: script_DirectShot (copy)
    if p1.AbilityOne > tick() then
        return;
    end;

    if p1.AbilityUsed > tick() then
        return;
    end;

    if p2.Character.Humanoid:GetState() == Enum.HumanoidStateType.Freefall or p2.Character.Humanoid:GetState() == Enum.HumanoidStateType.Jumping then
        return;
    end;

    if not p2.Character.IsRagdoll.Value then
        return script_DirectShot(p1, p2, p3);
    end;
end;