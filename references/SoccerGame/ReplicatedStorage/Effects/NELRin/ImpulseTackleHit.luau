  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("TweenService");
game:GetService("UserInputService");
game:GetService("RunService");
local Debris = game:GetService("Debris");
require(ReplicatedStorage.Shared.Essentials);
local VfxManager = require(ReplicatedStorage.Shared.VfxManager);

return function(p1) -- Line: 10
    -- upvalues: VfxManager (copy), Debris (copy)
    local Char = p1.Char;
    local v2 = script.Tackle:Clone();
    v2:PivotTo(Char.HumanoidRootPart.CFrame);
    v2.Parent = workspace.Debris;
    VfxManager.Emit(v2);
    Debris:AddItem(v2, 5);
end;