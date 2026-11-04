  

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
require(ReplicatedStorage.AbilityBalancing);
require(ReplicatedStorage.Modules.getPlayerTarget);
local script_CrownHopper = require(script.CrownHopper);
local script_LobPass = require(script.LobPass);

return function(p1, p2, p3, ...) -- Line: 21
    -- upvalues: script_LobPass (copy), script_CrownHopper (copy)
    if p1.AbilityTwo > tick() then
        return;
    end;

    if p1.AbilityUsed > tick() then
        return;
    end;

    if not p2.Character.Values.HasBall.Value then
        return;
    end;

    if p2.Character.Humanoid:GetState() == Enum.HumanoidStateType.Freefall then
        return;
    end;

    if not p2.Character.IsRagdoll.Value then
        if p3:HasTag("CrownHopped") then
            return script_LobPass(p1, p2, p3);
        end;

        return script_CrownHopper(p1, p2, p3, ...);
    end;
end;