 
 

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local VfxManager = require(ReplicatedStorage.Shared.Utility.VfxManager);
require(ReplicatedStorage.Shared.Utility.SfxManager);
local Essentials = require(ReplicatedStorage.Shared.Utility.Essentials);
local _ = Players.LocalPlayer;
workspace:FindFirstChild("Debris");

return function(p1, p2) -- Line: 11
    -- upvalues: Essentials (copy), VfxManager (copy)
    local Character = p2.Character;
    Character:FindFirstChild("HumanoidRootPart");

    if Character:GetAttribute("Invis") then
        return;
    end;

    local v3 = tick();

    repeat
        task.wait(0.1);
        local v4 = Essentials:CreateClone(Character, 1);
        VfxManager.DestroyEffect(v4, 1);
    until tick() - v3 > 0.45;
end;