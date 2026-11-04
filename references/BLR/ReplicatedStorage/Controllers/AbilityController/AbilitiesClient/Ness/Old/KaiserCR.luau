  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("ServerScriptService");
game:GetService("Players");
game:GetService("RunService");
game:GetService("TweenService");
local ReplicatedStorage2 = game:GetService("ReplicatedStorage");
require(ReplicatedStorage.Shared.Essentials);
require(ReplicatedStorage.Shared.Trove);
require(ReplicatedStorage.Shared.SoundManager);
local Popup = require(ReplicatedStorage.Shared.Popup);
require(ReplicatedStorage.Shared.VfxManager);
require(ReplicatedStorage2.AbilityBalancing);
require(ReplicatedStorage2.Shared.AbilityUtils);

return function(p1, p2, p3, p4) -- Line: 16
    -- upvalues: Popup (copy), ReplicatedStorage2 (copy)
    local v5;

    if typeof(p4) == "table" then
        v5 = p4.target;
    else
        v5 = p4;
        p4 = {};
    end;

    print(" Kaiser CR Cutscene");
    local Magnitude = (p3.HumanoidRootPart.Position - v5.HumanoidRootPart.Position).Magnitude;

    if Magnitude > 160 then
        Popup.Popup(p2, "Kaiser is too far! (" .. tostring(100 - Magnitude) .. ")");

        return;
    end;

    if v5.Humanoid:GetState() == Enum.HumanoidStateType.Jumping or v5.Humanoid:GetState() == Enum.HumanoidStateType.Freefall then
        Popup.Popup(p2, "Kaiser player must be on the ground");

        return;
    end;

    if p3.Humanoid:GetState() == Enum.HumanoidStateType.Jumping or p3.Humanoid:GetState() == Enum.HumanoidStateType.Freefall then
        Popup.Popup(p2, "must be on the ground");

        return;
    end;

    if ReplicatedStorage2.GameValues.AwakeningCutscene.Value then
        return;
    end;

    print("fire server");
    p1.AbilityService.Ability:Fire("KaiserXNess", v5, p4.chemReaction);
    ReplicatedStorage2.GameValues.AwakeningCutscene.Value = true;
    task.wait(0.5);
    ReplicatedStorage2.GameValues.AwakeningCutscene.Value = false;
end;