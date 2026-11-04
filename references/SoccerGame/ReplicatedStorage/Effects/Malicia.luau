  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("TweenService");
local Debris = game:GetService("Debris");
game:GetService("RunService");
require(ReplicatedStorage.Shared.Essentials);
local VfxManager = require(ReplicatedStorage.Shared.VfxManager);
require(ReplicatedStorage.Shared.SoundManager);
require(ReplicatedStorage.Shared.Popup);

return function(p1) -- Line: 11
    -- upvalues: VfxManager (copy), Debris (copy)
    local Char = p1.Char;
    local v2 = script.Kickvfx:Clone();
    v2.Parent = workspace.Debris;
    v2.CFrame = Char.HumanoidRootPart.CFrame * CFrame.new(0, 0, -5);
    VfxManager.Emit(v2);
    Debris:AddItem(v2, 2);
end;