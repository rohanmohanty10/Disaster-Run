  

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
local script_DemonicOverheadKick = require(script.DemonicOverheadKick);

return function(p1, p2, p3, ...) -- Line: 18
    -- upvalues: Popup (copy), script_DemonicOverheadKick (copy)
    if p1.AbilityTwo > tick() then
        return;
    end;

    if p1.AbilityUsed > tick() then
        return;
    end;

    if not p3.Values.HasBall.Value then
        return Popup.Popup(p2, "You need the ball to use this!");
    end;

    if p2.Character.IsRagdoll.Value then
        return;
    end;

    if p2.Character.Humanoid:GetState() ~= Enum.HumanoidStateType.Freefall then
        return script_DemonicOverheadKick(p1, p2, p3, ...);
    end;
end;