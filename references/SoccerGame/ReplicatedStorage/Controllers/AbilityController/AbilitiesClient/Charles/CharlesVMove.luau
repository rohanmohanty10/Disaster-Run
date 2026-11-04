  

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
local Popup = require(ReplicatedStorage.Shared.Popup);
require(ReplicatedStorage.Shared.VfxManager);
require(ReplicatedStorage.AbilityBalancing);
local getPlayerTarget = require(ReplicatedStorage.Modules.getPlayerTarget);
local script_ContrarianDribble = require(script.ContrarianDribble);
local script_ContrarianPass = require(script.ContrarianPass);

return function(p1, p2, p3, ...) -- Line: 21
    -- upvalues: Popup (copy), getPlayerTarget (copy), script_ContrarianPass (copy), script_ContrarianDribble (copy)
    if p1.AbilityTwo > tick() then
        return;
    end;

    if p1.AbilityUsed > tick() then
        return;
    end;

    if p3.Humanoid:GetState() == Enum.HumanoidStateType.Jumping or p3.Humanoid:GetState() == Enum.HumanoidStateType.Freefall then
        return;
    end;

    if not p3.Values.HasBall.Value then
        Popup.Popup(p2, "You NEED the ball vro 🥀💔");

        return;
    end;

    if p2.Character.IsRagdoll.Value then
        return;
    end;

    if not p3:GetAttribute("ContrarianPass") then
        return script_ContrarianDribble(p1, p2, p3, ...);
    end;

    local v4 = getPlayerTarget(false);

    if v4 then
        return script_ContrarianPass(p1, p2, p3, v4);
    end;

    Popup.Popup(p2, "Requires teammate to pass to!");
end;